set -e
IMAGE_TAG=flaviens/ubuntuzsh:latest
echo building $IMAGE_TAG
docker build -t $IMAGE_TAG .
echo "To push image, do:"
echo "docker login registry-1.docker.io"
echo "docker push $IMAGE_TAG"
