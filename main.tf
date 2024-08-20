terraform {
  cloud {

    organization = "CLOUD_27"

    workspaces {
      name = "module_project_workspace"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

module "users" {
  source = "./modules/users"
  users = {
    sysadmin1    = {}
    sysadmin2    = {}
    dbadmin1     = {}
    dbadmin2     = {}
    monitoruser1 = {}
    monitoruser2 = {}
    monitoruser3 = {}
    monitoruser4 = {}
  }
}

module "groups" {
  source = "./modules/groups"
  groups = {
    SysAdmin = {}
    DBAdmin  = {}
    Monitor  = {}
  }
}

module "group_memberships" {
  source = "./modules/group_memberships"
  memberships = {
    sysadmin1    = { user = "sysadmin1", groups = ["SysAdmin"] }
    sysadmin2    = { user = "sysadmin2", groups = ["SysAdmin"] }
    dbadmin1     = { user = "dbadmin1", groups = ["DBAdmin"] }
    dbadmin2     = { user = "dbadmin2", groups = ["DBAdmin"] }
    monitoruser1 = { user = "monitoruser1", groups = ["Monitor"] }
    monitoruser2 = { user = "monitoruser2", groups = ["Monitor"] }
    monitoruser3 = { user = "monitoruser3", groups = ["Monitor"] }
    monitoruser4 = { user = "monitoruser4", groups = ["Monitor"] }
  }
  user_names  = module.users.user_names
  group_names = module.groups.group_names
}

module "access_policies" {
  source = "./modules/access_policies"
  policies = {
    SysAdminPolicy = {
      group = "SysAdmin"
      policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Action   = "*"
            Effect   = "Allow"
            Resource = "*"
          }
        ]
      })
    }
    DBAdminPolicy = {
      group = "DBAdmin"
      policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Action = [
              "rds:*",
            ]
            Effect   = "Allow"
            Resource = "*"
          }
        ]
      })
    }
    MonitorPolicy = {
      group = "Monitor"
      policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Action = [
              "cloudwatch:Describe*",
              "cloudwatch:Get*",
              "cloudwatch:List*",
              "logs:Describe*",
              "logs:Get*",
              "logs:List*",
              "logs:StartQuery",
              "logs:StopQuery"
            ]
            Effect   = "Allow"
            Resource = "*"
          }
        ]
      })
    }
  }
}



module "my_vpc" {
  source     = "./modules/vpc"
  cidr_block = "172.15.0.0/16"
  name       = "modules_vpc"
}


module "sec-groups" {
  source  = "app.terraform.io/CLOUD_27/sec-groups/aws"
  version = "2.0.0"
  # insert required variables here
  //vpc_id = aws_vpc.this.id
  vpc_id = module.my_vpc.my_vpc_id
}

