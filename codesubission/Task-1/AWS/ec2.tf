resource "aws_instance" "app_machine" {
  ami           = "ami-084568db4383264d4"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_1.id
  key_name      = aws_key_pair.project_key.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  tags          = { Name = "AppMachine" }
}

resource "aws_instance" "tools_machine" {
  ami           = "ami-084568db4383264d4"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_2.id
  key_name      = aws_key_pair.project_key.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  tags          = { Name = "ToolsMachine" }
}
