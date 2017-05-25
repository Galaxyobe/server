# Supervisord


## install

> sudo apt-get install supervisor

## 

> sudo cp service/supervisord.service /etc/systemd/system/

> sudo systemctl enable supervisor.service

> sudo systemctl start supervisor.service

##

> sudo cp -r conf.d /etc/supervisor/

> sudo supervisorctl reread

> sudo supervisorctl update

> sudo supervisorctl start scrapyd