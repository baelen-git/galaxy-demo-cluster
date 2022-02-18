variable "api_key" {
  type = string
  description = "API Key Id from Intersight"
}
variable "secretkey" {
  type = string
  description = "The path to your secretkey for Intersight OR the your secret key as a string"
}
variable "organization" {
  type = string
  description = "Organization Name"
  default = "default"
}

variable "ssh_key" {
  type = string
  description = "The ssh_key for the IKS cluster"
}

variable "vc_password" {
  type = string
  description = "The password for your vCenter"
}

variable "tags" {
  type = list(map(string))
  description = "tags you want to use"
  default = []
}