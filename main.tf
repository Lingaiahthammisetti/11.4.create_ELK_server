resource "aws_instance" "elk_ec2" {
    ami           = data.aws_ami.rhel_info.id
    instance_type = var.ec2_instance.instance_type
    vpc_security_group_ids = [var.allow_everything]

    #user_data = file("${path.module}/install.sh")
    # root_block_device {
    # volume_size = 50  # Size of the root volume in GB
    # volume_type = "gp2"  # General Purpose SSD (you can change the volume type if needed)
    # delete_on_termination = true  # Automatically delete the volume when the instance is terminated
    # }

    tags = {
        Name = "ELK_server"
    }
}
resource "aws_route53_record" "elk_r53" {
    zone_id = var.zone_id
    name    = "elk.${var.domain_name}"
    type    = "A"
    ttl     = 1
    records = [aws_instance.elk_ec2.public_ip]
    allow_overwrite = true
}