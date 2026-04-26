#Create the Identity for simulator
resource "aws_iot_thing" "air_sensor" {
  name = "air_quality_sim_01"
}

#Generate the keys the Phthon script will use to authenticate
resource "aws_iot_certificate" "sim_cert" {
  active = true
}

#Policy
#Policy acts as a firewall for the IoT device

resource "aws_iot_policy" "sim_policy" {
  name = "AllowSensorPublish"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action   = ["iot:Connect", "iot:Publish"]
      Effect   = "Allow"
      Resource = ["*"]
    }]
  })
}

resource "aws_iot_policy_attachment" "att" {
  policy = aws_iot_policy.sim_policy.name
  target = aws_iot_certificate.sim_cert.arn
}

