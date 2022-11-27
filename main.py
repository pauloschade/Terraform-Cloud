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

def start():
  print("what do you wish to do?")
  print("0 - quit")
  print("1 - make changes")
  print("2 - show instances")
  print("3 - show users")
  print("4 - run terraform")

def changes():
  print("1 - add instance\n")
  print("2 - remove instance\n")
  print("3 - add sg\n")
  print("4 - add sg rule\n")
  print("5 - remove sg rule\n")
  print("6 - switch region\n")
  print("7 - add user\n")
  print("8 - remove user\n")

def run_terraform():
  print("0 - init\n")
  print("1 - deploy instances\n")
  print("2 - destroy instances\n")
  print("3 - plan\n")


def making_changes(pyTerra, option):
  if option == "1":
    pyTerra.add_instance()
    return
  
  if option == "2":
    pyTerra.remove_instance()
    return
  
  if option == "3":
    pyTerra.add_sg()
    return
  
  if option == "4":
    pyTerra.add_sg_rule()
    return
  
  if option == "5":
    pyTerra.remove_sg_rule()
    return
  
  if option == "6":
    pyTerra.switch_region()
    return
  
  if option == "7":
    pyTerra.add_user()
    return

  if option == "8":
    pyTerra.remove_user()
    return
  
  print("Invalid option")


def running_terraform(pyTerra, option):
  if option == "0":
    pyTerra.run_init()
    return
  
  if option == "1":
    pyTerra.run_apply()
    return
  
  if option == "2":
    pyTerra.run_destroy()
    return
  
  if option == "3":
    pyTerra.run_plan()
    return
  
  print("Invalid option")


def terraform_prog(pyTerra):
  welcome()

  while True:
    cont = input("do you wish to continue using terraform manager? (y/n): ")
    if cont == "n":
      break
    start()
    action = input("What do you wish to do?\n")
    
    if action == "0":
      break

    if action == "1":
      changes()
      option = input("What do you wish to do?\n")
      making_changes(pyTerra, option)
      continue
      
    if action == "2":
      pyTerra.show_instances()
      continue

    if action == "3":
      pyTerra.show_users()
      continue

    if action == "4":
      run_terraform()
      option = input("What do you wish to do?\n")
      running_terraform(pyTerra, option)
      continue

    
  goodbye()

if __name__ == "__main__":
  pyterra = pyTerraform()
  terraform_prog(pyterra)