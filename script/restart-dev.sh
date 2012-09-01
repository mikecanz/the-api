#!/bin/sh
   
cd /home/ec2-user/sg-constable/
for n in `ps aux | grep plack | grep -v grep  | awk -F' ' '{print $2}'`; do kill $n; done;
/usr/bin/perl /usr/local/bin/plackup -r -R lib -E development Starman --workers=3 -p 5000 -a bin/app.pl --error-log logs/development.log --access-log logs/access.log 2>&1 &
sudo /sbin/service nginx restart
