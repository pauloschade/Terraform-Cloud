import json
from pyTerraform.entity.Instance import Instance
from pyTerraform.service.SGService import SGService

class InstanceService:
  def __init__(self):
    self.json_path = "tfvars.json"
  
  def add_instance(self, json_data, instance):
    json_data["instances"][instance.name] = json.loads(instance.to_json())
    return json_data
  
  def remove_instance(self, json_data, instance_name):
    json_data["instances"].pop(instance_name)
    return json_data

  def _get_instance(self, json_data ,instance_name):
    instance_json = json_data["instances"][instance_name]
    return Instance(**instance_json)