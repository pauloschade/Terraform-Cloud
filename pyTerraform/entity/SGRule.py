import json
class SGRule:
    def __init__(self, name="default" ,rule_type = "ingress", cidr = "0.0.0.0/0", protocol = "tcp", from_port = "80", to_port = "80"):
        self.name = name
        self.rule_type = rule_type
        self.cidr = [cidr]
        self.from_port = from_port
        self.to_port = to_port
        self.protocol = protocol

    def to_json(self):
        return json.dumps(self, default=lambda o: o.__dict__, sort_keys=True, indent=4)