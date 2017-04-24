#!/bin/bash
source $HOME/.profile
sudo docker pull checkraiser/giftpoint-backend
sudo docker stop backend
sudo docker rm backend 
sudo docker run --name backend --link some-postgres:postgres -p 80:80 -e RAILS_SERVE_STATIC_FILES=$RAILS_SERVE_STATIC_FILES -e SECRET_KEY_BASE=$SECRET_KEY_BASE -e PORT=80 -e RAILS_ENV=production -d checkraiser/giftpoint-backend
sudo docker exec backend bash -c 'RAILS_ENV=production bin/rails db:migrate'