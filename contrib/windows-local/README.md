### CKAN Windows Development Environment

Context: these scripts enable two scenarios:
- Running and debugging CKAN python code locally (from IDE like PyCharm) and 
- Running CKAN python code as a Docker container (to test images which will be deployed). 

In both scenarios backend components (Postgres, Solr, Redis and Datapusher) run as Docker containers.

#### Setup CKAN locally from the source  
Create Python 2.7 virtual environment using Anaconda 

    conda create -n ckan python=2.7

or using virtualenv (after installing Python 2.7)

    pip install virtualenv
    mkvirtualenv --system-site-packages ckan
    workon ckan
    
Run below to setup CKAN locally and run it from the command line (to confirm the setup was successful). 

    cd c:\git\ckan\contrib\windows-local     
    setup.cmd
    docker stop ckan
    START paster serve development.ini
    explorer http://localhost:5000/   
 

Debug or run with PyCharm using paster.py and the below configuration  

    In PyCharm open Run, Edit Configuration as set:  
    
    Script path: 
    c:\git\ckan\contrib\docker\windows-local\paster.py   
    
    Parameters: 
    serve development.ini  


### Run CKAN as a Docker container 
Run below script to build the ckan Docker image using the latest CKAN code and run all components as Docker containers. 
  

    cd c:\git\ckan\contrib\windows-local  
    run_docker-compose.cmd test  
    explorer http://localhost:5000/  
  

###### References  
How to install on Windows 7:  
https://github.com/ckan/ckan/wiki/How-to-Install-CKAN-2.5.2-on-Windows-7  
Installing from docker-compose:  
https://docs.ckan.org/en/latest/maintaining/installing/install-from-docker-compose.html
