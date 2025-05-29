resource "aws_key_pair" "example" {
  key_name   =   var.key_name# Replace with your desired key name
  public_key = file(var.public_key_path)  # Replace with the path to your public key file
}