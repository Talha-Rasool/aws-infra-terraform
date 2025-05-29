#code works if you have already s3 bucket , otherwise need to create first.

terraform {
  backend "s3" {
    bucket = "your bucket name"
    key    = "key for storing tf.state file"
    region = ""
    
  }
}