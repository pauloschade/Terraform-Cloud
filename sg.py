from pyTerraform.helpers.pyTerraformCreation import pyTerraformSG

def welcome():
  print("-------------------------------\n")
  print("welcome to the terraform manager")
  print("-------------------------------\n")
  print("\n")

def goodbye():
  print("-------------------------------\n")
  print("goodbye from terraform manager")
  print("-------------------------------\n")
  print("\n")

def rules():
  print("You can choose the following: \n")
  print("7 - add sg\n")
  print("8 - add sg rule\n")
  print("9 - quit program\n")


def terraform_prog(pyTerra):
  welcome()

  while True:
    rules()
    action = input("What do you wish to do?\n")
    
    if action == "9":
      goodbye()
      return
    
    if action == "7":
      sg = pyTerra._crete_sg("web", "vpc-123456")
      pyTerra.add_sg(sg)
      continue

    if action == "8":
      pyTerra.add_rule("web")


if __name__ == "__main__":
  pyterra = pyTerraformSG()
  terraform_prog(pyterra)