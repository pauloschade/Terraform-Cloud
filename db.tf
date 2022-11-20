resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [module.vpc.subnet_id]
  tags = { Name = "DB subnet group" }
}

resource "aws_db_instance" "web" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  db_name              = "mydb"
  username             = "cloud"
  password             = "cloudu"
  parameter_group_name = "default.mysql5.7"
  availability_zone    = "${var.aws_region}"
  skip_final_snapshot  = true

  db_subnet_group_name   = module.vpc.subnet_id
  vpc_security_group_ids = [module.security_groups.db_id]
}