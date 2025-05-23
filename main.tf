resource "aws_instance" "elk_ec2" {
    ami           = data.aws_ami.rhel_info.id
    instance_type = var.ec2_instance.instance_type
    vpc_security_group_ids = [var.allow_everything]
    tags = {
        Name = "ELK_server"
    }
}
resource "aws_route53_record" "elk_r53" {
    zone_id = var.zone_id
    name    = "elastic-search.${var.domain_name}"
    type    = "A"
    ttl     = 1
    records = [aws_instance.elk_ec2.public_ip]
    allow_overwrite = true
}