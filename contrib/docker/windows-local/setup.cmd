REM This script will setup CKAN local windows dev environment for easier debugging.
REM This will replace CKAN docker container. Other components should run as docker containers.
REM Based on https://github.com/ckan/ckan/wiki/How-to-Install-CKAN-2.5.2-on-Windows-7

pushd %~dp0

IF EXIST development.ini del development.ini /P

pip install -r ..\..\..\requirements.txt
pip install python-magic-bin==0.4.14 python-dotenv==0.10.3 configparser==3.7.4
pip install --upgrade bleach

docker-compose -f ..\docker-compose.yml down
docker-compose -f ..\docker-compose.yml build db solr
docker-compose -f ..\docker-compose.yml up -d db solr
REM redis datapusher

copy ckan\config\who.ini . /Y

paster make-config ckan development.ini
python populate_ini.py
paster --plugin=ckan db init -c development.ini

popd

ECHO To debug CKAN use IDE (like PyCharm). To start CKAN directly use the below "paster" command, then open http://localhost:5000
ECHO paster serve development.ini

