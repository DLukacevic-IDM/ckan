ECHO OFF

REM This script sets up CKAN locally on Windows 10 to enable debugging from IDE.
REM This script uses docker containers to run depending compoents (all except the CKAN container).
REM This script mirrors the role of "contrib/docker/ckan-entrypoint.sh" and includes some instructions from this Wiki:
REM https://github.com/ckan/ckan/wiki/How-to-Install-CKAN-2.5.2-on-Windows-7

REM Navigate to scripts dir (needed to be able to reference relative dirs).
pushd %~dp0

REM Runs depending containers
CALL run-docker-compose.cmd debug
timeout 10

REM Install required Python packages
pip install -r ..\..\requirements.txt
pip install python-magic-bin==0.4.14 python-dotenv==0.10.3 configparser==3.7.4
pip install --upgrade bleach

REM Creates config files
IF NOT EXIST who.ini MKLINK who.ini ..\..\ckan\config\who.ini
IF NOT EXIST development.ini (
  paster make-config --no-interactive ckan development.ini
  python populate_ini.py
)

REM Navigate to the ckan parent dir.
pushd ..\..\..

REM Initializes CKAN postgres db (requires installing and uninstalling CKAN python package).
pip install -e ckan

REM Setting this env. variable allows using "paster" commands without explicitly specifying config file.
SET CKAN_INI=%cd%\ckan\contrib\windows-local\development.ini
paster --plugin=ckan db init

popd
popd

ECHO To debug CKAN use IDE (like PyCharm). To start CKAN directly use the below "paster" command, then open http://localhost:5000
ECHO paster serve development.ini

ECHO ON