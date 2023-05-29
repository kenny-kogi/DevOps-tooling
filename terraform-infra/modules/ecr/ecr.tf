resource "aws_ecr_repository" "library-api" {
  name = "${var.repos.library_api}-${var.branch}"
  tags = {
    Name = "${var.repos.loantracker_backend_be}-${var.branch}"
    Environment = var.tags.env_prefix
  }
}