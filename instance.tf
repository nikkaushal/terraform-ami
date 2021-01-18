resource "aws_instance" "ami_instance" {
  ami                   = data.aws_ami.ami.id
  instance_type         = "t3.small"
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  tags                  = {
    Name                = "${var.COMPONENT}-ami"
  }

}


resource "aws_security_group" "allow-ssh" {
  name                 = "allow-${var.COMPONENT}-ami-sg"
  description          = "allow-${var.COMPONENT}-ami-sg"

  ingress {
    description       = "SSH"
    from_port         = 22
    to_port           = 443
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
  }

  egress {
    from_port         = 0
    to_port           = 0
    protocol          =  "-1"
    cidr_blocks       = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-${var.COMPONENT}-ami-sg"
  }
}

resource "null_resource" "provisioner" {
  provisioner "remote-exec" {
    connection {
      host              = aws_instance.ami_instance.public_ip
      user              = "root"
      password          = "DevOps321" //hardcoding user id and pwd in code is not a good practise and causes securty breaches
    }
    inline = [
      "yum install make -y",
      "git clone https://github.com/nikkaushal/shell-scripting.git",
      "cd shell-scripting/roboshop-project",
      "make ${var.COMPONENT}"
    ]
  }
}
