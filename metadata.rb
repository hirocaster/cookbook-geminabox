name             'geminabox'
maintainer       'hirocaster'
maintainer_email 'hohtsuka@gmail.com'
license          'MIT'
description      'Installs/Configures geminabox'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.1'

depends "apt"
depends "build-essential"
depends "nginx"
depends "ruby_rbenv"
depends "ruby_build"
depends "ssl_certificate"
depends "backup"
