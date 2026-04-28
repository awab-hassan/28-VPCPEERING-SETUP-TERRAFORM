# Configure AWS providers for both regions
provider "aws" {
  alias  = "tokyo"
  region = "ap-northeast-1"
}

provider "aws" {
  alias  = "sydney"
  region = "ap-southeast-2"
}
