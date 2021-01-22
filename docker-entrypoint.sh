#!/bin/sh

echo '== Instalando Gems =='
bundle check || bundle install --jobs=$(nproc)

echo '== Limpando logs e tmps =='
bundle exec rails log:clear tmp:clear
rm -rf ./tmp/pids/*

echo '== Iniciando Servidor =='
rails server -b 0.0.0.0
