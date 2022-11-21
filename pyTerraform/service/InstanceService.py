import json
from pyTerraform.entity.Instance import Instance
from pyTerraform.service.SGService import SGService

class InstanceService:
  def __init__(self):
    self.json_path = "tfvars.json"
  
  def add_instance(self, json_data, instance):
    json_data["instances"][instance.name] = json.loads(instance.to_json())
    return json_data

  def add_sg(self, instance_name, sg):
    instance = self._get_instance(instance_name)
    instance.add_sg(sg)
    return instance

  def remove_sg(self, instance_name, sg_name):
    instance = self._get_instance(instance_name)
    instance.remove_sg(sg_name)
    return instance

  def _get_instance(self, json_data ,instance_name):
    instance_json = json_data["instances"][instance_name]
    return Instance(**instance_json)

  def _crete_instance(self, name):
    return Instance(name)