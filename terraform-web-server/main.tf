# --- 1. OSの自動取得 ---
data "aws_ami" "recent_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }
}

# --- 2. AWSの接続設定 ---
provider "aws" {
  region = "ap-northeast-1" 
}

# --- 3. ネットワーク(VPC) ---
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags       = { Name = "terraform-vpc" }
}

# --- 4. 出口(Internet Gateway) ---
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

# --- 5. サブネット ---
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

# --- 6. 道案内(Route Table) ---
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.rt.id
}

# --- 7. 門番(Security Group) ---
resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# --- 8. サーバー(EC2) ---
resource "aws_instance" "web" {
  ami           = data.aws_ami.recent_amazon_linux.id
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello from Terraform!</h1>" > /var/www/html/index.html
              EOF

  tags = { Name = "Web-Server-by-Terraform" }
}

# --- 9. IPアドレスの出力 ---
output "public_ip" {
  value = aws_instance.web.public_ip
}
