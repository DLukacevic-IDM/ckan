ECHO OFF
pushd %~dp0

docker-compose -f ..\docker\docker-compose.yml -f docker-local.yml down

IF "%1"=="debug" (
  docker-compose -f ..\docker\docker-compose.yml -f docker-local.yml build db solr redis
  docker-compose -f ..\docker\docker-compose.yml -f docker-local.yml up -d db solr redis
) ELSE (
  docker-compose -f ..\docker\docker-compose.yml -f docker-local.yml build
  docker-compose -f ..\docker\docker-compose.yml -f docker-local.yml up -d
  timeout 10
  docker-compose -f ..\docker\docker-compose.yml -f docker-local.yml up -d ckan
  docker-compose -f ..\docker\docker-compose.yml -f docker-local.yml logs --tail=all
)

popd
ECHO ON
