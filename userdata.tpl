#cloud-config
package_update: true
package_upgrade: true
runcmd:
  - sudo dnf install -y docker
  - sudo systemctl start docker
  - sudo systemctl enable docker
  - sudo usermod -aG docker ec2-user
  - sudo docker version
