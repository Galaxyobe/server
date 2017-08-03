#!/bin/bash

echo 'copy nginx/conf.d files to etc/nginx/conf.d/ ...'
sudo cp -r nginx/conf.d/* /etc/nginx/conf.d/
echo 'copy supervisord.d files to etc/supervisord.d/ ...'
sudo cp -r supervisord.d/* /etc/supervisord.d/
echo 'restart nginx ...'
sudo service nginx restart
