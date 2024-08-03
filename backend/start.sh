#!/usr/bin/env bash

# copy template if no .env available
if [ ! -f '.env' ]; then
  cp config/.env.tpl .env
fi

# start stack
docker-compose up -d

# get JWT & set it into env
JWT_SECRET=$(curl -s http://localhost:8080/auth/realms/formed-api/protocol/openid-connect/certs | jq -c '.keys[0]')
sed -i "s@JWT_SECRET=.*@JWT_SECRET=$JWT_SECRET@" .env

# restart stack in order to load JWT
docker-compose up -d
