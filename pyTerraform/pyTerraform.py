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
    self.change_default = "terraform workspace select default"
    self.change_alternate = "terraform workspace select alternate"
    self.instance_service = InstanceService()
    self.sg_service = SGService()


  def run_apply(self):
    self._run_process(self.apply + self.json_path)
  
  def run_destroy(self):
    self._run_process(self.destroy + self.json_path)
    self._clear_file()

  def run_init(self):
    self._run_process(self.init)
    self._init_workspaces()
    self._clear_file()
  
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

  def add_user(self):
    name = input("User name: ")
    rest = input("is this user restricted? (y/n)")
    self._add_user(name, rest)

  def remove_user(self):
    name = input("User name: ")
    self._remove_user(name)

  def show_instances(self):
    json_data  = self._open_json()
    self._print_json(json_data["instances"])

  def show_users(self):
    json_data  = self._open_json()
    self._print_json(json_data["users"])
  ## ----------------------------------------------------------------------
  ## ---------------------------- Helper Methods ---------------------------
  ## ----------------------------------------------------------------------
  def _run_process(self, arg):
    print("-------------------------------\n")
    print("APPLYING CHANGES\n")
    print("-------------------------------\n")
    p = subprocess.run(arg.split())
  
  def _add_instance(self):
    instance = create_instance()
    data = self._open_json()
    data = self.instance_service.add_instance(data, instance)
    self._write_json(data)
  
  def _add_sg(self, instance_name):
    data = self._open_json()
    instance = self.instance_service._get_instance(data, instance_name)
    instance_added = add_sg(instance)
    data = self.instance_service.add_instance(data, instance_added)
    self._write_json(data)
  
  def _remove_instance(self, instance_name):
    data = self._open_json()
    data = self.instance_service.remove_instance(data, instance_name)
    self._write_json(data)

  def _add_sg_rule(self, instance_name, sg_name):
    data = self._open_json()
    sg = self.sg_service._get_sg(data["instances"][instance_name], sg_name)
    add_sg_rule(sg)
    sg_edited = self.sg_service.add_sg(data["instances"][instance_name], sg)
    data["instances"][instance_name] = sg_edited
    self._write_json(data)

  
  def _remove_sg_rule(self, instance_name, sg_name, sg_rule_name):
    data = self._open_json()
    data_sg_rule_removed = self.sg_service.remove_rule(sg_name, sg_rule_name, data["instances"][instance_name])
    data["instances"][instance_name] = data_sg_rule_removed
    self._write_json(data)

  def _change_default(self):
    self._run_process(self.change_default)
    self.json_path = "tfvars.json"
    print("switched to default - east region")
  
  def _change_alternate(self):
    self._run_process(self.change_alternate)
    self.json_path = "tfvars_alternate.json"
    print("switched to alternate - west region")

  def _init_workspaces(self):
    print("Initializing workspaces")
    try:
      self._run_process("terraform workspace new alternate")
    except:
      pass
    try:
      self._change_default()
    except:
      pass
    print("Workspaces initialized")

  
  def _add_user(self, name, rest):
    data = self._open_json()
    if rest == "y":
      data["users"][name] = True
    else:
      data["users"][name] = False
    self._write_json(data)

  
  def _remove_user(self, name):
    data = self._open_json()
    data["users"].pop(name)
    self._write_json(data)
  
  def _open_json(self):
    with open(self.json_path) as f:
      data = json.load(f)
    return data
  
  def _write_json(self, data):
    with open(self.json_path, 'w') as f:
      json.dump(data, f, indent=2)

  def _print_json(self, data):
    print(json.dumps(data, indent=1))

  def _clear_file(self):
    json_data = self._open_json()
    json_data["instances"] = {}
    json_data["users"] = {}
    self._write_json(json_data)

  