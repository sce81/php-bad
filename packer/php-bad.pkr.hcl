packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.2.8"
    }
  }
}

variable "service_name" {
  type    = string
  default = "svc-php-bad"
}

variable "php_module" {
  type        = string
  description = "Remi module stream for PHP (CVE-2024-2961 remediation: stay on 8.1.x, patched build)."
  default     = "php:remi-8.1"
}

variable "php_version" {
  type        = string
  description = "Pinned PHP package version on the AMI (was 8.1.27; fixed in 8.1.28+)."
  default     = "8.1.28"
}

variable "php_fpm_image" {
  type        = string
  description = "Reference Docker base for parity with container scans."
  default     = "php:8.1.28-fpm"
}

source "amazon-ebs" "php_bad" {
  ami_name      = "${var.service_name}-php-${var.php_version}"
  instance_type = "t3.micro"
  region        = "us-east-1"

  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm-*-x86_64-gp2"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    owners      = ["amazon"]
    most_recent = true
  }

  ssh_username = "ec2-user"

  tags = {
    Service     = var.service_name
    PhpModule   = var.php_module
    PhpVersion  = var.php_version
    DockerImage = var.php_fpm_image
  }
}

build {
  name    = "php-bad"
  sources = ["source.amazon-ebs.php_bad"]

  provisioner "shell" {
    environment_vars = [
      "PHP_MODULE=${var.php_module}",
      "PHP_VERSION=${var.php_version}",
    ]
    inline = [
      "echo \"Building ${var.service_name} with ${var.php_module} PHP ${var.php_version} (${var.php_fpm_image})\"",
      "sudo yum install -y yum-utils",
      "sudo amazon-linux-extras install -y epel",
      "sudo yum install -y https://rpms.remirepo.net/enterprise/remi-release-7.rpm",
      "sudo yum-config-manager --enable remi-php81",
      "sudo yum install -y php-${var.php_version} php-fpm",
      "php -v | head -1",
    ]
  }
}
