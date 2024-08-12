#module "my_vpc" {
  #source = "./modules/vpc"
  #vpc_cidr_block = "172.15.0.0/16"
  #tags =  {
    #Name = "modules_vpc"
  #}
#}

resource "aws_vpc" "this" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.name
  }
}


#map(list(string) map(string))
#map(object)
