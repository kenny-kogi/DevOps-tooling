output "jenkins-host" {
  value = aws_instance.jenkins.private_ip
}

output "jenkins-sg" {
  value = aws_security_group.jenkins-sg
}
