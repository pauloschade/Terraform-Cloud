import json
from pyTerraform.entity.SG import SG
from pyTerraform.entity.SGRule import SGRule

class SGService:
  def __init__(self):
    self.json_path = "tfvars.json"

  def add_sg(self, json_data, sg):
    json_data["security_groups"][sg.name] = json.loads(sg.to_json())
    return json_data
  
  def remove_sg(self, json_data, sg_name):
    json_data["security_groups"].pop(sg_name)
    return json_data

  def add_rule(self, sg_name, rule):
    sg = self._get_sg(sg_name)
    sg.add_rule(rule)
    return sg

  def remove_rule(self, sg_name, rule, json_data):
    sg = self._remove_sg_rule(sg_name, rule, json_data)
    json_data["security_groups"][sg_name] = json.loads(sg.to_json())
    return json_data
  
  def _add_sg_rule(self, sg_name, rule, json_data):
    sg = self._get_sg(json_data, sg_name)
    sg.add_rule(rule)
    return sg

  def _remove_sg_rule(self, sg_name, rule, json_data):
    sg = self._get_sg(json_data, sg_name)
    sg.remove_rule(rule)
    return sg
  
  # def remove_rule(self, sg_name, rule_name, json_data):
  #   sg = self._get_sg(json_data, sg_name)
  #   sg.remove_rule(rule_name)
  #   return sg
  
  def _get_sg(self, json_data ,sg_name):
    sg_json = json_data["security_groups"][sg_name]
    return SG(**sg_json)