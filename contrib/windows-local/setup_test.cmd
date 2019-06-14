REM This script sets up test environment

REM install dev dependencies
pip install -r ../../dev-requirements.txt
pip install -r ../../requirement-setuptools.txt
pip install -r test-requirements.txt
cd ../../
python setup.py develop

REM Create test databases
docker exec -it db adduser --disabled-password --gecos "" ckan
docker exec -it db runuser -l ckan -c "createdb -O ckan ckan_test -E utf-8"
docker exec -it db runuser -l ckan -c "createdb -O ckan datastore_test -E utf-8"

REM Create datastore users
docker exec -it db runuser ckan -c "psql -c \"CREATE USER ckan_read WITH PASSWORD 'ckan';\""
docker exec -it db runuser ckan -c "psql -c \"GRANT USAGE ON SCHEMA public TO ckan_read;\""
docker exec -it db runuser ckan -c "psql -c \"GRANT SELECT ON ALL TABLES IN SCHEMA public TO ckan_read;\""

REM install npm packages
START /wait CMD /c npm install -g mocha-phantomjs@3.5.0 phantomjs@~1.9.1

cd contrib/windows-local  
ECHO OFF
ECHO please follow the steps below:
ECHO run: paster serve test-core.ini
ECHO open a new cmd and run: mocha-phantomjs http://localhost:5000/base/test/index.html
ECHO cd ../../ then run the command below in the virtualenv that you created:
ECHO nosetests -v --ckan --ckan-migration --reset-db  --with-pylons=contrib/windows-local/test-core.ini -d ckan ckanext
ECHO if you want to run individual tests add --tests for example: --tests=TestAppDispatcher.test_ask_around_flask_core_and_pylons_extension_route
ECHO add --with-html --html-report=test.html for better reporting
ECHO ON
