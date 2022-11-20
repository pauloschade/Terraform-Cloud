import subprocess
import json

class pyTerraform:
  def __init__(self):
    self.init = "terraform init"
    self.apply = "terraform apply -auto-approve -var-file="
    self.destroy =  "terraform destroy -auto-approve -var-file="
    self.plan = "terraform plan -var-file="
    self.json_path = "tfvars.json"
    self.counter_extra = 0
    self.added_instances = []

  def run_apply(self):
    self._run_process(self.apply + self.json_path)
    self._print_suc("INSTANCES DEPLOYED")
  
  def run_destroy(self):
    self._run_process(self.destroy + self.json_path)
    self._print_suc("INSTANCES DESTROYED")

  def run_init(self):
    self._run_process(self.init)
    self._print_suc("TERRAFORM INITIALIZED")
  
  def run_plan(self):
    self._run_process(self.plan + self.json_path)

  def add_micro_instance(self):
    self.counter_extra += 1
    self._add_instance(f"micro-{self.counter_extra}", self._micro_instance())
    self._print_suc("MICRO INSTANCE ADDED")
  
  def add_small_instance(self):
    self.counter_extra += 1
    self._add_instance(f"small-{self.counter_extra}" ,self._small_instance())
    self._print_suc("SMALL INSTANCE ADDED")
  
  def remove_last_instance(self):
    if len(self.added_instances) == 0:
      print("No instances to remove")
      return
    self._remove_instance(self.added_instances[-1])
    self.added_instances.pop()
    self._print_suc("INSTANCE REMOVED")
  
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

  def _remove_instance(self, instance):
    data = self._open_json()
    data["instances"].remove(instance)
    with open(self.json_path, "w") as f:
      json.dump(data, f, indent=2)


  def _add_instance(self, type, instance):
    data = self._open_json()
    data["instances"][type] = (instance)
    self.added_instances.append(type)
    with open(self.json_path, "w") as f:
      json.dump(data, f, indent=2)
  
  def _print_suc(self, txt):
    print(f"\033[1;32m{txt}")
    print("\033[1;0m")

  def _micro_instance(self):
    return  {
        "name"              : f"mc-Paulo-{self.counter_extra}",
        "size"              : "micro"
      }
  def _small_instance(self):
    return { 
        "name"              : f"sm-Paulo-{self.counter_extra}",
        "size"              : "small"
      }