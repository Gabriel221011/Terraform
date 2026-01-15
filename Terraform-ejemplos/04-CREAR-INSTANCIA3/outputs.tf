// Este fichero define las salidas del proyecto Terraform.
// Las salidas permiten mostrar información relevante después de aplicar la configuración.
// En este caso, mostramos la IP pública de la instancia "servidor1".

output "ip_publica_ec2_ejemplo" {
  value = aws_instance.ec2_ejemplo.public_ip
}

output "ec2_ejemplo_id" {
  value = aws_instance.ec2_ejemplo.id
}
