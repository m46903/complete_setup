variable "region" {
  description = " it will define the AWS region "
  default     = "us-east-1"
}
variable "server_port" {
  description = " http service listens on ths port from ec2's"
  default     = "80"
}

variable "ssh_port" {
  description = "ssh request to server  "
  default     = "22"
}

variable "db_port" {
  description = "db request to server  "
  default     = "3306"
}

variable "aws-ami" {
  description = "amazon machine image"
  default     = "ami-0323c3dd2da7fb37d"
}

variable "ami" {
  #Centos for us-east-1
  description = "Centos ami for us-east-1"
  default     = "ami-0affd4508a5d2481b"
}

variable "win_ami" {
  #win for us-east-1
  description = "Windows_Server-2012-R2_RTM"
  default     = "ami-00360458a879ed9a6"
}

variable "win_10_ami" {
  #win for us-east-1
  description = "BASE Windows10Ent ImageWindows_10 private ami"
  default     = "ami-045f9a31783f92f90"
}
 
variable "bastion_host" {
  #Bastion host is an aws ami for us-east-1
  description = "bastion aws-ami for us-east-1"
  default     = "ami-09ab237af4a23d09e"
}

variable "kali_linux" {
  #Bastion host is an aws ami for us-east-1
  description = "kali linux ubuntu-ami for us-east-1"
  default     = "ami-08c8387e171a3d095"
}

variable "docker_instance" {
  description = "AWS ec2 instance type"
  default     = "m5.xlarge"
  #default     = "t2.micro"
}

variable "indexer" {
  description = "AWS ec2 instance type"
  default     = "i3.4xlarge"
  #default     = "t2.micro"
}

variable "search_head" {
  description = "AWS ec2 instance type"
  default     = "m4.4xlarge"
  #default     = "t2.micro"
}

variable "cluster_master" {
  description = "AWS ec2 instance type"
  default     = "m4.large"
  #default     = "t2.micro"
}

variable "phantom" {
  description = "AWS ec2 instance type"
  default     = "t2.large"
}
variable "heavy_forwarder" {
  description = "AWS ec2 instance type"
  default     = "m5.large"
} 

variable "salt_master" {
  description = "AWS ec2 instance type"
  default     = "t2.xlarge"
  #default     = "t2.micro"
}

variable "db_instance" {
  description = "AWS ec2 instance type"
  default     = "t2.nano"
  #default     = "t2.micro"
}

variable "win2016_server" {
  description = "AWS ec2 instance type"
  default     = "m4.xlarge"
}

variable "ec2_instance" {
  description = "AWS ec2 instance type"
  default     = "t2.micro"
}

variable "nitro" {
  description = " t3a.micro is built on Nitro system which is required for AWS traffic mirroring"
  default     = "t3a.micro"
  
}

variable "key" {
  description = "key name"
  default     = "content-cyber-range-aws-key"
}

variable "phoenix_docker_key" {
  description = "phoenix_docker_key"
  default     = "phoenix_content-cyber-range-aws-key"
}

variable "db_count" {
  description = "how many ?"
  default     = 1
}

variable "my_public_ip" {
  description = "My laptop public IP address"
  #default = "73.251.127.250/32"
  default = "0.0.0.0/0"
}

variable "RDS_PASSWORD" { default = "psql1234" }

#variable "azs" {
#  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
#}

variable "aws_region" {
  description = " it will define the AWS region "
  default     = "us-east-1"
}

variable "aws_zone" {
  default = "us-east-1a"
}

variable "vault_url" {
  default = "https://releases.hashicorp.com/vault/1.4.2/vault_1.4.2_linux_amd64.zip"
}

variable "az1" {
  default = "us-east-1a"
}

variable "az2" {
  default = "us-east-1b"
}

variable "az3" {
  default = "us-east-1c"
}

variable "az4" {
  default = "us-east-1d"
}

variable "az5" {
  default = "us-east-1e"
}

variable "scenario" {
  default = "transit_gw"
}

data "aws_ami" "centos_7_victim" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "owner-id"
    values = ["952430311316"]
  }

  filter {
    name   = "name"
    values = ["centos7_victim"]
  }
}

data "aws_ami" "centos_8_victim" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "owner-id"
    values = ["952430311316"]
  }

  filter {
    name   = "name"
    values = ["centos8_victim"]
  }
}

data "aws_ami" "win2019_server_victim" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "owner-id"
    values = ["952430311316"]
  }

  filter {
    name   = "name"
    values = ["WindowsServer2019Base_Victim"]
  }
}

data "aws_ami" "win2016_server_victim" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "owner-id"
    values = ["952430311316"]
  }

  filter {
    name   = "name"
    values = ["WindowsServer2016Base_Victim"]
  }
}

data "aws_ami" "win2012r2_server_victim" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "owner-id"
    values = ["952430311316"]
  }

  filter {
    name   = "name"
    values = ["WindowsServer2012R2Base_Victim"]
  }
}

