# gem in a box
default[:geminabox][:base_directory] = "/srv/geminabox/current/data"
default[:geminabox][:directory][:owner] = "vagrant"
default[:geminabox][:directory][:group] = "vagrant"

# nginx configs
default['nginx']['default_site_enabled'] = false
default[:geminabox][:nginx][:port] = 80
default[:geminabox][:nginx][:ssl_port] = 443
default[:geminabox][:nginx][:server_name] = "_"
default[:geminabox][:nginx][:client_max_body_size] = '5M'

# ssl
default[:geminabox][:ssl][:enabled] = false
default[:geminabox][:ssl][:key] = ""
default[:geminabox][:ssl][:cert] = ""

# ruby
default["rbenv"]["rubies"] = "2.3.0"
default["rbenv"]["gems"] = { "2.3.0" => [{ name: "bundler" }] }

# backup
default[:geminabox][:backup][:enabled] = false
default[:geminabox][:backup][:s3_access_key_id] = ""
default[:geminabox][:backup][:s3_secret_access_key] = ""
default[:geminabox][:backup][:region] = "us-east-1"
default[:geminabox][:backup][:bucket] = ""
