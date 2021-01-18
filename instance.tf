resource "aws_instance" "ami_instance" {
  ami                   = data.aws_ami.ami.id
  instance_type         = "t3.small"
  tags = {
    name                = "front-ami"
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
