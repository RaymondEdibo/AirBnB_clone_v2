<<<<<<< HEAD
# Configures web server for deployment of web_static using Puppet

# Nginx configuration file
$nginx_conf = "server {
    listen 80 default_server;
    listen [::]:80 default_server;
    add_header X-Served-By ${hostname};
    root   /var/www/html;
    index  index.html index.htm;
    location /hbnb_static {
        alias /data/web_static/current;
        index index.html index.htm;
    }
    location /redirect_me {
        return 301 http://https://www.youtube.com/watch?v=QH2-TGUlwu4;
    }
    error_page 404 /404.html;
    location /404 {
      root /var/www/html;
      internal;
    }
}"

package { 'nginx':
  ensure   => 'present',
  provider => 'apt'
} ->

file { '/data':
  ensure  => 'directory'
} ->

file { '/data/web_static':
  ensure => 'directory'
} ->

file { '/data/web_static/releases':
  ensure => 'directory'
} ->

file { '/data/web_static/releases/test':
  ensure => 'directory'
} ->

file { '/data/web_static/shared':
  ensure => 'directory'
} ->

file { '/data/web_static/releases/test/index.html':
  ensure  => 'present',
  content => "Holberton School Puppet\n"
} ->

file { '/data/web_static/current':
  ensure => 'link',
  target => '/data/web_static/releases/test'
} ->

exec { 'chown -R ubuntu:ubuntu /data/':
  path => '/usr/bin/:/usr/local/bin/:/bin/'
}

file { '/var/www':
  ensure => 'directory'
} ->

file { '/var/www/html':
  ensure => 'directory'
} ->

file { '/var/www/html/index.html':
  ensure  => 'present',
  content => "Holberton School Nginx\n"
} ->

file { '/var/www/html/404.html':
  ensure  => 'present',
  content => "Ceci n'est pas une page\n"
} ->

file { '/etc/nginx/sites-available/default':
  ensure  => 'present',
  content => $nginx_conf
} ->

exec { 'nginx restart':
  path => '/etc/init.d/'
=======
# Puppet script that sets up web servers for the deployment of web_static.

include stdlib

exec { 'update':
  command => '/usr/bin/apt-get update',
}

package { 'nginx':
  ensure  => installed,
  name    => 'nginx',
  require => Exec['update'],
}

file { [ '/data/', '/data/web_static/', '/data/web_static/releases/',
          '/data/web_static/releases/test/' ]:
  ensure => directory,
  owner  => 'ubuntu',
  group  => 'ubuntu',
}

file { '/data/web_static/shared':
  ensure => directory,
  owner  => 'ubuntu',
  group  => 'ubuntu',
}

exec { 'Creates fake index.html':
  path    => ['/usr/bin', '/usr/sbin', '/bin'],
  command => 'echo "Hello Nginx!" > /data/web_static/releases/test/index.html',
}

exec { 'Change user:group owner of index.html':
  path    => ['/usr/bin', '/usr/sbin', '/bin'],
  command => 'chown -hR ubuntu:ubuntu /data/web_static/releases/test/index.html',
}

file { '/data/web_static/current':
  ensure => 'link',
  owner  => 'ubuntu',
  group  => 'ubuntu',
  target => '/data/web_static/releases/test'
}

$to_add = '
        location /hbnb_static/ {
		                alias /data/web_static/current/;
        }'

file_line { 'location /hbnb_static/':
  ensure  => 'present',
  path    => '/etc/nginx/sites-available/default',
  after   => 'server_name _;',
  line    => $to_add,
  require => Package['nginx'],
}

service { 'nginx':
  ensure     => running,
  enable     => true,
  hasrestart => true,
  require    => Package['nginx'],
>>>>>>> 65edb161fde4681e45545a2fdd50ba5f5ae48df6
}
