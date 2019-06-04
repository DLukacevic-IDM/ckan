pushd %~dp0
pushd ..
docker-compose down
docker-compose down
docker-compose build
docker-compose up -d
timeout 10
docker-compose restart ckan
docker-compose logs -f --tail=all
popd
popd
