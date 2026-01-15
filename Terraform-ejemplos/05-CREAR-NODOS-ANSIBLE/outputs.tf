output "ansible_nodes_public_ips" {
  value = aws_instance.ansible_node[*].public_ip
  description = "IPs públicas de las instancias para Ansible"
}
