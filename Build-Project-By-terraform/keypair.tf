resource "aws_key_pair" "deploy-keypair" {
  key_name   = "deployer-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAFGcXlgVo0oHHCV5UlPoQRgdAPRpb/yhFYH2YPcjkkt ziad@Zeyad-Ashour"
}
