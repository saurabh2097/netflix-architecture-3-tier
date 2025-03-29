#### RDS ####
/*resource "aws_db_subnet_group" "netflix-db-sub-grp" {
  name       = "netflix-db-sub-grp"
  subnet_ids = ["${aws_subnet.netflix-pvt-sub-3.id}","${aws_subnet.netflix-pvt-sub-4.id}"]
}

resource "aws_db_instance" "netflix-db" {
  allocated_storage           = 100
  storage_type                = "gp3"
  engine                      = "mysql"
  engine_version              = "8.0.39"
  instance_class              = "db.m5.large"
  identifier                  = "netflix-db"
  username                    = "admin"
  password                    = "Devopsbysaurabh20*"
  parameter_group_name        = "default.mysql8.0"
  db_subnet_group_name        = aws_db_subnet_group.swiggy-db-sub-grp.name
  vpc_security_group_ids      = ["${aws_security_group.netflix-db-sg.id}"]
  multi_az                    = true
  skip_final_snapshot         = true
  publicly_accessible          = false

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}
*/
