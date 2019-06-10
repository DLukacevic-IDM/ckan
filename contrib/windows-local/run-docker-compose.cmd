ECHO OFF
pushd %~dp0

SET command=%1

IF "%command%"=="debug" (
  CALL :DOWN
  CALL :BUILD_BACKEND
  CALL :UP_BACKEND
)

IF "%command%"=="test" (
  CALL :DOWN
  CALL :BUILD
  CALL :UP
  CALL :LOGS 5
  CALL :EMPTY_CKAN_VOLUME
  CALL :COPY_CKAN_LOCAL_TO_VOLUME
)

IF "%command%"=="down"  CALL :DOWN
IF "%command%"=="buid"  CALL :BUILD
IF "%command%"=="up"    CALL :UP
IF "%command%"=="buid-b"  CALL :BUILD_BACKEND
IF "%command%"=="up-b"    CALL :UP_BACKEND
IF "%command%"=="logs"  CALL :LOGS %2

REM TODO
REM backup
REM volumes-from
REM docker run -it --volumes-from ckan --volumes-from db --volumes-from solr debian:stretch /bin/bash

GOTO :END

:BUILD
docker-compose -f ..\docker\docker-compose.yml -f docker-local.yml build
EXIT /B

:UP
docker-compose -f ..\docker\docker-compose.yml -f docker-local.yml up -d
timeout 10
docker-compose -f ..\docker\docker-compose.yml -f docker-local.yml up -d ckan
EXIT /B

:DOWN
docker-compose -f ..\docker\docker-compose.yml -f docker-local.yml down
docker-compose -f ..\docker\docker-compose.yml -f docker-local.yml down
EXIT /B

:BUILD_BACKEND
docker-compose -f ..\docker\docker-compose.yml -f docker-local.yml build db solr redis

:UP_BACKEND
docker-compose -f ..\docker\docker-compose.yml -f docker-local.yml up -d db solr redis

:LOGS
SET tail=%1
IF "%tail%"=="" SET tail=all
docker-compose -f ..\docker\docker-compose.yml -f docker-local.yml logs --tail=%tail%
EXIT /B

:EMPTY_CKAN_VOLUME
docker run --volumes-from ckan debian:stretch rm -r /var/lib/ckan/resources
docker run --volumes-from ckan debian:stretch rm -r /var/lib/ckan/storage
docker run --volumes-from ckan debian:stretch rm -r /var/lib/ckan/webassets
EXIT /B

:COPY_CKAN_LOCAL_TO_VOLUME
docker cp %USERPROFILE%\ckan\storage\resources ckan:/var/lib/ckan/resources
docker cp %USERPROFILE%\ckan\storage\storage ckan:/var/lib/ckan/storage
docker cp %USERPROFILE%\ckan\storage\webassets ckan:/var/lib/ckan/webassets

:COPY_CKAN_VOLUME_TO_LOCAL
REM TODO

:RUN_VOLUMES_CONTAINER
REM TODO

:BACKUP_VOLUMES
REM TODO


:END

popd
ECHO ON
