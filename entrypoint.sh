#!/bin/bash

# Corrige permissões do master.key
[ -f ./config/master.key ] && chmod 644 ./config/master.key

# Garante existência e permissão do log
mkdir -p ./log
touch ./log/development.log
chmod 664 ./log/development.log

# Garante existência do tmp/pids e apaga server.pid se travado
mkdir -p ./tmp/pids
rm -f ./tmp/pids/server.pid

# Corrige permissões gerais no tmp/
chmod -R 775 ./tmp

# Executa o comando passado (rails s, sidekiq, etc)
exec "$@"
