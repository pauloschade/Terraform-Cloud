from pyTerraform.pyTerraform import pyTerraform

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
  print("0 - init\n")
  print("1 - deploy instances\n")
  print("2 - destroy instances\n")
  print("3 - plan\n")
  print("4 - add instance\n")
  print("7 - remove instance\n")
  print("9 - quit program\n")

def rules_instances():
  print("You can choose the following: \n")
  print("1 - small\n")
  print("2 - tiny\n")

def rules_sg():
  print("You can choose the following: \n")
  print("1 - web\n")
  print("2 - db\n")

def terraform_prog(pyTerra):
  welcome()

  while True:
    rules()
    action = input("What do you wish to do?\n")
    
    if action == "9":
      goodbye()
      return
    
    if action == "0":
      pyTerra.run_init()
      continue
    
    if action == "1":
      pyTerra.run_apply()
      continue

    if action == "2":
      pyTerra.run_destroy()
      continue
      
    if action == "3":
      pyTerra.run_plan()
      continue  

    if action == "4":
      pyTerra.add_instance()
    
    if action == "7":
      pyTerra.remove_last_instance()
      continue


if __name__ == "__main__":
  pyterra = pyTerraform()
  print(pyterra)
  terraform_prog(pyterra)