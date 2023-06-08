resource "aws_ec2_transit_gateway" "tgw" {
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc_korea_attachment" {
  vpc_id             = aws_vpc.korea_main.id
  subnet_ids         = [aws_subnet.korea_public_subnet.id, aws_subnet.korea_public_subnet_2.id]
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc_second_attachment" {
  vpc_id             = aws_vpc.korea_second.id
  subnet_ids         = [aws_subnet.korea_second_public_subnet.id, aws_subnet.korea_second_public_subnet_2.id]
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc_third_attachment" {
  vpc_id             = aws_vpc.korea_third.id
  subnet_ids         = [aws_subnet.korea_third_public_subnet.id, aws_subnet.korea_third_public_subnet_2.id]
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
}
