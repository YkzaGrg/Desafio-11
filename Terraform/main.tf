provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "us-east-1"
}

data "aws_ami" "ubuntu" {
most_recent = true

filter {
name = "name"
values = ["ubuntu/images/hvm-ssd/ubuntu-focal-*-amd64-server-*"]
}

filter {
name = "virtualization-type"
values = ["hvm"]
}

owners = ["099720109477"] # Canonical
}

resource "aws_instance" "ec2_instance" {
    ami = data.aws_ami.ubuntu.id
    count = "${var.number_of_instances}"
    subnet_id = "${var.subnet_id}"
    instance_type = "${var.instance_type}"
    key_name = "${var.ami_key_pair_name}"
}
