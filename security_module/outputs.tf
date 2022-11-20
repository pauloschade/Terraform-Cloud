output "web_id" {
  value = aws_security_group.web.id
}

output "db_id" {
  value = aws_security_group.db.id
}

output "lb_id" {
  value = aws_security_group.lb.id
}

output "autoscaling_id" {
  value = aws_security_group.autoscaling.id
}
