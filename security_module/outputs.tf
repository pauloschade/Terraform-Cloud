output "web" {
  value = aws_security_group.web.id
}

output "db" {
  value = aws_security_group.db.id
}

output "lb" {
  value = aws_security_group.lb.id
}

output "autoscaling" {
  value = aws_security_group.autoscaling.id
}
