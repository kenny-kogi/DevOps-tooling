variable "tags" {}
variable "repos" {
  type = object({
    library_api = string
  })
}
variable "branch" {}