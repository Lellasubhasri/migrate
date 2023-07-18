data "aws_vpc" "onprem_vpc" {
  filter {
    name = "tag:Name"
    values = ["onprem-vpc"]
  }
}

resource "aws_vpc_peering_connection" "peering" {
  vpc_id = module.vpc.vpc_id
  peer_vpc_id = data.aws_vpc.onprem_vpc.id
  auto_accept = true
  peer_owner_id = "296572906806"

    accepter {
    allow_remote_vpc_dns_resolution = true
    }
    requester {
  allow_remote_vpc_dns_resolution = true
    }
    tags = {
      Name = "peering"
    }
}

resource "aws_vpc_peering_connection_accepter" "target_accepter" {
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
  auto_accept = true
    tags = {
    Side = "Accepter"
  }
}

data "aws_route_tables" "target_routetable" {
    vpc_id = module.vpc.vpc_id
    filter {
        name = "tag:Name"
        values = ["migration-vpc-default"]
  }
}

resource "aws_route" "peer-target" {
  count                     = length(data.aws_route_tables.target_routetable.ids)
  route_table_id            = tolist(data.aws_route_tables.target_routetable.ids)[count.index]
  destination_cidr_block    = local.vpc_cidr3
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
}

data "aws_route_tables" "route1" {
    vpc_id = data.aws_vpc.onprem_vpc.id
    filter {
        name = "tag:Name"
        values = ["onprem-vpc-default"]
  }
}

resource "aws_route" "onprem-route" {
  count                   = length(data.aws_route_tables.route1.ids)
  route_table_id            = tolist(data.aws_route_tables.route1.ids)[count.index]
  destination_cidr_block    = local.vpc_cidr4
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
}