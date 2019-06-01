##Setup Windows Dev Environment

### Install from docker-compose
Run below script or follow instructions to install from docker-compose  
https://docs.ckan.org/en/latest/maintaining/installing/install-from-docker-compose.html  

cd C:\git\ckan\contrib\docker  
run_docker-compose.cmd  
Open http://localhost:5000  

### Run CKAN locally from PyCharm
Run below script or follow instructions from the Wiki   
https://github.com/ckan/ckan/wiki/How-to-Install-CKAN-2.5.2-on-Windows-7

windows-local\setup.cmd  

In PyCharm, open Run -> Edit Configuration:  
Script path:        C:\git\ckan\contrib\docker\windows-local\paster.py   
Parameters: serve   serve development.ini  
Working directory:  C:\git\ckan 
  
