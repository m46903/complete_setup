terraform {
  backend "s3" {
    #encrypt = true
    bucket = "content-cyber-range-terraform-state"
    key    = "tgw_splunk_docker_servers_in_us-east-1/terraform.tfstate"
    region = "us-east-1"
    #dynamodb_table = "terraform-state"
  }
}