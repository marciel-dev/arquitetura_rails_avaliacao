#!/bin/bash

docker stop $(docker ps -q) 2>/dev/null
docker rm $(docker ps -a -q) 2>/dev/null
docker rmi -f $(docker images -q) 2>/dev/null
docker volume rm $(docker volume ls -q) 2>/dev/null
docker network rm $(docker network ls -q) 2>/dev/null
docker system prune -a --volumes -f

echo "Docker zerado com sucesso!"
echo "Containers:"
docker ps -a
echo "Imagens:"
docker images
echo "Volumes:"
docker volume ls
echo "Redes:"
docker network ls