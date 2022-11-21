import json
from pyTerraform.entity.SG import SG
from pyTerraform.entity.SGRule import SGRule

class SGService:
  def __init__(self):
    self.json_path = "tfvars.json"

  def add_sg(self, json_data, sg):
    json_data[sg.name] = json.loads(sg.to_json())
    return json_data

  def add_rule(self, sg_name, rule):
    sg = self._get_sg(sg_name)
    sg.add_rule(rule)
    return sg
  
  def remove_rule(self, sg_name, rule_name):
    sg = self._get_sg(sg_name)
    sg.remove_rule(rule_name)
    return sg
  
  def _get_sg(self, json_data ,sg_name):
    sg_json = json_data[sg_name]
    return SG(**sg_json)

  def _crete_sg(self, name):
    return SG(name)

  def _create_rule(self, rule_type, cidr, protocol, from_port, to_port):
    return SGRule(rule_type, cidr, protocol, from_port, to_port)