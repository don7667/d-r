# Install docker
apt update
apt -y install git curl make apt-transport-https ca-certificates gnupg2
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo debian-wheezy main" > /etc/apt/sources.list.d/docker.list
apt update
apt install -y docker-engine
service docker start

# Install docker-compose 
curl -L "https://github.com/docker/compose/releases/download/1.9.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

current_user=''
if [ "$SUDO_USER" ];
then
    current_user="$SUDO_USER"
elif [ $USER != "root" ];
then
    current_user="$USER"
else
    echo "Input your user name, please:"
    read current_user
fi

# Giving non-root access (optional)
groupadd docker
gpasswd -a "$current_user" docker
service docker restart
