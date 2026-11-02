packer {
  required_plugins {
    docker = {
      version = ">= 1.0.8"
      source  = "github.com/hashicorp/docker"
    }
  }
}

variable "php_fpm_image" {
  type        = string
  description = "PHP-FPM runtime image for svc-php-bad (CVE-2024-2961 remediated in 8.1.28+)"
  default     = "php:8.1.28-fpm"
}

variable "php_rem_module" {
  type        = string
  description = "Remi module stream for AMI builds (php:remi-X.Y)"
  default     = "php:remi-8.1"
}

source "docker" "php_bad" {
  image  = var.php_fpm_image
  commit = true
}

build {
  name    = "svc-php-bad"
  sources = ["source.docker.php_bad"]
}
