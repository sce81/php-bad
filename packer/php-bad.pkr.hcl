packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.2.8"
    }
  }
}

variable "php_dnf_module" {
  type        = string
  description = "Remi DNF module stream (php:remi-X.Y) for svc-php-bad runtime"
  default     = "php:remi-8.1"
}

variable "php_version" {
  type        = string
  description = "PHP package version pin; 8.1.28+ remediates CVE-2024-2961 (iconv)"
  default     = "8.1.28"
}

source "amazon-ebs" "svc_php_bad" {
  ami_name      = "svc-php-bad-php-${var.php_version}-{{timestamp}}"
  instance_type = "t3.micro"
  region        = "us-east-1"
  source_ami_filter {
    filters = {
      name                = "al2023-ami-*-x86_64"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    owners      = ["amazon"]
    most_recent = true
  }
  ssh_username = "ec2-user"
}

build {
  name    = "svc-php-bad"
  sources = ["source.amazon-ebs.svc_php_bad"]

  provisioner "shell" {
    environment_vars = [
      "PHP_DNF_MODULE=${var.php_dnf_module}",
      "PHP_VERSION=${var.php_version}",
    ]
    inline = [
      "sudo dnf install -y https://rpms.remirepo.net/enterprise/remi-release-9.rpm",
      "sudo dnf module reset php -y",
      "sudo dnf -y module enable \"${PHP_DNF_MODULE}\"",
      "sudo dnf install -y \"php-${PHP_VERSION}\" php-fpm",
      "php -v",
    ]
  }
}
