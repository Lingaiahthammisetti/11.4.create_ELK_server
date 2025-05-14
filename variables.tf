variable "allow_everything" {
   type = string
   default = "sg-09c7c70bd56f0d58b"
}

variable "ec2_instance" {
   default = {
        instance_type  = "t3.medium"
   }
}
variable "zone_id" {
    default = "Z08032413NTE19HSX8KA1"
}
variable "domain_name" {
  default = "lingaiah.online"
}