variable "name" {
  description = "The name of the security group"
  type        = string
}

variable "description" {
  description = "Description fo the security group"
  type        = string
  default     = "Managed by terraform"
}

variable "vpc_id" {
  description = "The VPC ID creating the security group"
  type        = string
}

variable "ingress_rules" {
  description   = "Ingress rules list"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }]
}

variable "egress_rules" {
  description   = "Egress rules list"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [ {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  } ]
}