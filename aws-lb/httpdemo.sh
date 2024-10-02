#! /bin/bash -xe

apt update -qq
apt install -qqy -o Dpkg::Use-Pty=0 nginx
cd /var/www/html/
rm -vf *
export TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
cat > index.html << __EOF
<html>
<head></head>
Hello from $(curl -qs -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/hostname) <br>
Instance id is $(curl -qs -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id)
</html>
__EOF
