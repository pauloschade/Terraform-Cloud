import json
class SG:
  def __init__(self, name, rules = {}):
    self.name = name
    self.rules = rules
  
  def add_rule(self, rule):
    self.rules[rule.name] = rule
  
  def remove_rule(self, rule_name):
    self.rules.pop(rule_name)
  
  def to_json(self):
    return json.dumps(self, default=lambda o: o.__dict__, sort_keys=True, indent=4)