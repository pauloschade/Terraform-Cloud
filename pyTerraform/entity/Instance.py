import json
class Instance:
  def __init__(self, name, size, security_groups = {}):
    self.name = name
    self.size = size
    self.security_groups = security_groups
  
  def add_sg(self, sg):
    self.security_groups[sg.name] = sg
  
  def remove_sg(self, sg_name):
    self.security_groups.pop(sg_name)
  
  def to_json(self):
    return json.dumps(self, default=lambda o: o.__dict__, sort_keys=True, indent=4)