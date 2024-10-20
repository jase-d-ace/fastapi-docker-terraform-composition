variable "instance_name" {
    description = "Value of the Name of the EC2 Instance"
    type        = string
    default     = "FastApiJsonApi"
}

variable "key_name" {
    description = "SSH Key Name"
    type        = string
    default     = "jase_test_key"
}