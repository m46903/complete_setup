resource "aws_db_subnet_group" "psql-subnet-vpc-2" {
  name        = "psql-subnet-vpc-2"
  description = "RDS subnet group"
  #subnet_ids  = [aws_subnet.vpc-1-sub-b.id, aws_subnet.vpc-1-sub-bb.id]
  subnet_ids = [aws_subnet.vpc-2-sub-b.id, aws_subnet.vpc-2-sub-c.id]
}

resource "aws_db_parameter_group" "psql-parameters-vpc-2" {
  name        = "psql-parameters-vpc-2"
  family      = "postgres12"
  description = "psql parameter group"
}

# Follwoing are the steps to access postgrs db from a centos ec2
# 1: yum install https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm -y
# 2: yum install postgresql12 -y
# 3: psql -h psql-db-vpc-2.c9fowi1eofeq.us-east-1.rds.amazonaws.com -d psql -U cnc
# 4: \l

resource "aws_db_instance" "test-psql-vpc-2" {
  allocated_storage       = 100 # 100 GB of storage, gives us more IOPS than a lower number
  engine                  = "postgres"
  #engine_version          = "12.2"
  engine_version          = "12.5"
  instance_class          = "db.m4.large" # use micro if you want to use the free tier
  identifier              = "psql-db-vpc-2"
  name                    = "psql"
  username                = "cnc"            # username
  password                = var.RDS_PASSWORD # password
  db_subnet_group_name    = aws_db_subnet_group.psql-subnet-vpc-2.name
  parameter_group_name    = aws_db_parameter_group.psql-parameters-vpc-2.name
  multi_az                = "true" # set to true to have high availability: 2 instances synchronized with each other
  vpc_security_group_ids  = [aws_security_group.allow_psql_vpc_2.id]
  storage_type            = "gp2"
  backup_retention_period = 7 # how long you’re going to keep your backups
  storage_encrypted       = "true"
  #availability_zone       = aws_subnet.main-private-1.availability_zone # prefered AZ
  skip_final_snapshot = true # skip final snapshot when doing terraform destroy
  tags = {
    Name = "psql_db_instance_vpc_2"
  }
}

