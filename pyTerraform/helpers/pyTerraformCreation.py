import json
from pyTerraform.entity.SG import SG
from pyTerraform.entity.SGRule import SGRule
from pyTerraform.entity.Instance import Instance

def create_sg_rule():
  name = input("Enter rule name")
  rule_type = input("Enter rule type (ingress/egress): ")
  cidr = input("Enter cidr: ")
  protocol = input("Enter protocol: ")
  from_port = input("Enter from port: ")
  to_port = input("Enter to port: ")
  return SGRule(name, rule_type, cidr, protocol, from_port, to_port)


def add_sg_rule(sg):
  while True:
    add_rule = input("Add rule? (y/n): ")
    if add_rule == "y":
      sg.add_rule(create_sg_rule())
    else:
      return sg

def create_sg():
  sg_name = input("Enter security group name: ")
  sg = SG(sg_name)
  add_sg_rule(sg)

def add_sg(instance):
  while True:
    add_sg = input("Add security group? (y/n): ")
    if add_sg == "y":
      sg = create_sg()
      instance.add_sg(sg)
    else:
      return instance


def create_instance():
  name = input("Enter instance name: ")
  size = input("Enter instance size (small/tiny): ")
  instance = Instance(f"{name}-{size}",size)
  add_sg(instance)
  
