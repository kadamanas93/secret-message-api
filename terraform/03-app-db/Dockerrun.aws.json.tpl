{
  "AWSEBDockerrunVersion": "1",
  "Image": {
    "Name": "${ecr_url}:latest",
    "Update": "true"
  },
  "Ports": [{
    "ContainerPort": "8080"
  }]
}