#/bin/bash
# Script to provision the vagrant machine
# If this gets too complex, consider using ansible

export DEBIAN_FRONTEND=noninteractive
# boilerplate if you ever need mysql
debconf-set-selections <<< 'mysql-server mysql-server/root_password password vagrant'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password vagrant'


echo 'Updating the aptitude repository...'
apt-get -y update > /dev/null

packages=('python' 'python-pip' 'python-dev' 'git' 'nginx' 'mysql-server' 'uwsgi' 'uwsgi-plugin-python' 'nodejs' 'npm')

for package in "${packages[@]}"
do
    if dpkg --get-selections | grep -q "^$package[[:space:]]*install$" >/dev/null
    then
        echo "Skipping the installation of $package"
    else
        echo "Installing $package..."
        apt-get install -y $package > /dev/null
    fi
done

echo "Removing automatic installs, that are no longer required..."
apt-get -y autoremove > /dev/null

echo "Installing bower..."
ln -s /usr/bin/nodejs /usr/bin/node
cd /opt/{{cookiecutter.package_name}}/git
npm install bower -g --silent > /dev/null

echo "Installing npm requirements with bower..."
bower install --allow-root > /dev/null

# Change permissions on config files if they are not already 644
chmod 644 /opt/{{cookiecutter.package_name}}/git/ops/config/*

echo "Configuring Nginx"
cp /opt/{{cookiecutter.package_name}}/git//ops/config/nginx_conf /etc/nginx/sites-available/nginx_conf > /dev/null
ln -s /etc/nginx/sites-available/nginx_conf /etc/nginx/sites-enabled/
rm -rf /etc/nginx/sites-available/default

echo 'Configuring uWWSGI'
touch /var/log/uwsgi/emperor.log
chown www-data:www-data /var/log/uwsgi/emperor.log
mkdir /opt/{{cookiecutter.package_name}}/log
touch /opt/{{cookiecutter.package_name}}/log/uwsgi.log
chown www-data:www-data /opt/{{cookiecutter.package_name}}/log/uwsgi.log
cp /opt/{{cookiecutter.package_name}}/git/ops/config/uwsgi.conf /etc/init
cp /opt/{{cookiecutter.package_name}}/git/ops/config/uwsgi_conf.ini /etc/uwsgi/apps-available/
ln -s /etc/uwsgi/apps-available/uwsgi_conf.ini /etc/uwsgi/apps-enabled

echo 'Checking the python version...'
if [ $(python -V 2>&1 | grep -c "2.7") -eq 0 ]
then
    >&2 echo 'Please ensure that python 2.7 is installed and is the default python version'
    exit 1
fi

echo 'Installing the virtual environment...'
pip install virtualenv > /dev/null
virtualenv /opt/{{cookiecutter.package_name}}/env > /dev/null
chown -R vagrant: /opt/{{cookiecutter.package_name}}/env
source /opt/{{cookiecutter.package_name}}/env/bin/activate

cd /opt/{{cookiecutter.package_name}}/git
echo 'Installing the Python packages required in the virtualenv...'
pip install --upgrade setuptools > /dev/null
pip install -r requirements.txt > /dev/null

echo 'Starting Nginx'
service nginx restart > /dev/null

echo 'Starting uWSGI'
service uwsgi restart > /dev/null

unset DEBIAN_FRONTEND
echo 'The installation has completed!'
