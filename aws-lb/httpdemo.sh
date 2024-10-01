#! /bin/bash -xe

apt update -qq
apt install -qqy -o Dpkg::Use-Pty=0 nginx
cd /var/www/html/
rm -vf *
cat > index.html << __EOF
<html>
<head></head>
Hello from $(curl -qs http://169.254.169.254/latest/meta-data/hostname) <br>
Instance id is $(curl -qs http://169.254.169.254/latest/meta-data/instance-id)
</html>
__EOF
