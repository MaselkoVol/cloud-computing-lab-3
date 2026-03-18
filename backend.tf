terraform {
  backend "gcs" {
    bucket = "tf-state-lab3-maselko-volodymyr-13"
    prefix = "env/dev/var-13"
  }
}