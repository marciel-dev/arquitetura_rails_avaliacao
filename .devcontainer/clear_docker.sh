#!/bin/bash

# Para todos os containers em execução
docker stop $(docker ps -q) 2>/dev/null

# Remove todos os containers (em execução ou parados)
docker rm $(docker ps -a -q) 2>/dev/null

# Remove todas as imagens
docker rmi -f $(docker images -q) 2>/dev/null

# Remove todos os volumes
docker volume rm $(docker volume ls -q) 2>/dev/null

# Remove todas as redes personalizadas
docker network rm $(docker network ls -q) 2>/dev/null

# Executa uma limpeza completa (containers parados, imagens não usadas, volumes e redes)
docker system prune -a --volumes -f

echo "Docker zerado com sucesso! Verifique os recursos restantes (se houver):"
echo "Containers:"
docker ps -a
echo "Imagens:"
docker images
echo "Volumes:"
docker volume ls
echo "Redes:"
docker network ls