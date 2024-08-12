//rewriting the code to implement dynamic blocks
resource "aws_security_group" "sg" {
  name = var.name
  description = var.description
  vpc_id = var.vpc_id

#Dynamic ingress rules
dynamic "ingress" {
  for_each = var.ingress_rules
  content {
    from_port = ingress.value.from_port
    to_port = ingress.value.to_port
    protocol = ingress.value.protocol
    cidr_blocks = ingress.value.cidr_blocks
  }
}

#Dynamic egress rules
dynamic "egress" {
  for_each = var.egress_rules
  content {
    from_port = egress.value.from_port
    to_port = egress.value.to_port
    protocol = egress.value.protocol
    cidr_blocks = egress.value.cidr_blocks
  }
}

}



/* resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "test_service"
  }
}

#Input to be passed as an input in the module and on the root main.tf
variable "vpc_id" {
  type = string
}


#map(list(string) map(string))
#map(object) */





# map(list(string)) map(string) 
# map(object)
/* variable "aws_security_groups" {
description = ""
type = map(object({
description= string
ingress_rules = map(object({
from_port = number
to_port = number
protocol = string
cidr_blocks = list(string)
}))
egress_rules = map(object({
from_port = number
to_port = number
protocol = string
cidr_blocks = list(string)
}))
}))

default= {
  "my_first_security_group " = {
    description = ""
    ingress_rules = {
      from_port = 0
      to_port   = 0
      protocol  = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
    egress_rules = {
      from_port = 0
      to_port   = 0
      protocol  = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
} */