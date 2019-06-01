REM This script will setup CKAN local windows dev environment for easier debugging.
REM This will replace CKAN docker container. Other components should run as docker containers.
REM Based on https://github.com/ckan/ckan/wiki/How-to-Install-CKAN-2.5.2-on-Windows-7

SET ts=%DATE:~-4%%DATE:~4,2%%DATE:~7,2%_%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%
SET ts=%ts: =0%

pushd %~dp0
pushd ..\..\..\

IF EXIST who.ini REN who.ini who_%ts%.ini
IF EXIST development.ini REN development.ini development_%ts%.ini

copy ckan\config\who.ini . /Y
copy .\contrib\docker\windows-local\development.ini . /Y

pip install -r requirements.txt
pip install python-magic-bin==0.4.14
pip install --upgrade bleach

docker stop ckan
paster --plugin=ckan db init -c development.ini
REM paster serve development.ini

popd
popd
