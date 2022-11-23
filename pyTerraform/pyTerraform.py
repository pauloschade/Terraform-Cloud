import subprocess
import json
from pyTerraform.service.InstanceService import InstanceService
from pyTerraform.service.SGService import SGService
from pyTerraform.helpers.pyTerraformCreation import create_sg_rule, create_sg, create_instance, add_sg, add_sg_rule

class pyTerraform:
  def __init__(self):
    self.init = "terraform init"
    self.apply = "terraform apply -auto-approve -var-file="
    self.destroy =  "terraform destroy -auto-approve -var-file="
    self.plan = "terraform plan -var-file="
    self.json_path = "tfvars.json"
    self.counter_extra = 0
    self.instance_service = InstanceService()
    self.sg_service = SGService()
    self.change_default = "terraform workspace select default"
    self.change_alternate = "terraform workspace select alternate"


  def run_apply(self):
    self._run_process(self.apply + self.json_path)
    self._print_suc("INSTANCES DEPLOYED")
  
  def run_destroy(self):
    self._run_process(self.destroy + self.json_path)
    self._print_suc("INSTANCES DESTROYED")

  def run_init(self):
    self._init_workspaces()
    self._run_process(self.init)
    self._print_suc("TERRAFORM INITIALIZED")
  
  def run_plan(self):
    self._run_process(self.plan + self.json_path)

  def add_instance(self):
    self._add_instance()

  def remove_instance(self):
    instance_name = input("Instance name: ")
    self._remove_instance(instance_name)

  def add_sg(self):
    instance_name = input("Instance name: ")
    self._add_sg(instance_name)

  def add_sg_rule(self):
    instance_name = input("Instance name: ")
    sg_name = input("SG name: ")
    self._add_sg_rule(instance_name, sg_name)

  def remove_sg_rule(self):
    instance_name = input("Instance name: ")
    sg_name = input("SG name: ")
    sg_rule_name = input("SG rule name: ")
    self._remove_sg_rule(instance_name, sg_name, sg_rule_name)

  def switch_region(self):
    region = input("Region (east/west): ")
    if region == "east":
     self._change_default()
    elif region == "west":
      self._change_alternate()
    else:
      print("Invalid region")
      return
  
  def _run_process(self, arg):
    print("-------------------------------\n")
    print("APPLYING CHANGES\n")
    p = subprocess.Popen(arg, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    print("-------------------------------\n")
    retval = p.wait()

  def _open_json(self):
    with open(self.json_path) as f:
      data = json.load(f)
    return data
  
  def write_json(self, data):
    with open(self.json_path, 'w') as f:
      json.dump(data, f, indent=2)
  
  def _add_instance(self):
    instance = create_instance()
    data = self._open_json()
    data = self.instance_service.add_instance(data, instance)
    self.write_json(data)
  
  def _add_sg(self, instance_name):
    data = self._open_json()
    instance = self.instance_service._get_instance(data, instance_name)
    instance_added = add_sg(instance)
    data = self.instance_service.add_instance(data, instance_added)
    self.write_json(data)
  
  def _remove_instance(self, instance_name):
    data = self._open_json()
    data = self.instance_service.remove_instance(data, instance_name)
    self.write_json(data)

  def _add_sg_rule(self, instance_name, sg_name):
    data = self._open_json()
    sg = self.sg_service._get_sg(data["instances"][instance_name], sg_name)
    add_sg_rule(sg)
    sg_edited = self.sg_service.add_sg(data["instances"][instance_name], sg)
    data["instances"][instance_name] = sg_edited
    self.write_json(data)

  
  def _remove_sg_rule(self, instance_name, sg_name, sg_rule_name):
    data = self._open_json()
    data_sg_rule_removed = self.sg_service.remove_rule(sg_name, sg_rule_name, data["instances"][instance_name])
    data["instances"][instance_name] = data_sg_rule_removed
    self.write_json(data)
    
  
  def _print_suc(self, txt):
    print(f"\033[1;32m{txt}")
    print("\033[1;0m")

  def _change_default(self):
    p = subprocess.Popen(self.change_default, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    self.json_path = "tfvars.json"
    print("switched to default - east region")
  
  def _change_alternate(self):
    p = subprocess.Popen(self.change_alternate, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    self.json_path = "tfvars_alternate.json"
    print("switched to alternate - west region")

  def _init_workspaces(self):
    print("Initializing workspaces")
    try:
      self._run_process("terraform workspace new alternate")
    except:
      print("alternate workspace already exists")