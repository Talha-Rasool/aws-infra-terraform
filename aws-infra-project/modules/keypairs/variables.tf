variable "key_name" {
  description = "Name to assign to the key pair in AWS"
  type        = string
}

variable "public_key_path" {
  description = "Path to the local public key file (e.g., ~/.ssh/id_ed25519.pub)"
  type        = string
}
