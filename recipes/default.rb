#
# Cookbook Name:: geminabox
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apt"
include_recipe "build-essential"
include_recipe "nginx"

package "git"

include_recipe "ruby_build"
include_recipe "ruby_rbenv::system"


%w(000-default default).each do |site|
  nginx_site site do
    enable false
  end
end

if(node[:geminabox][:ssl][:enabled])
  if(node[:geminabox][:ssl][:key].nil?)
    cert = ssl_certificate "geminabox" do
      namespace "geminabox"
      notifies :restart, "service[nginx]"
    end
    geminabox_key = cert.key_content
    geminabox_cert = cert.cert_content
  else
    geminabox_key = node[:geminabox][:ssl][:key]
    geminabox_cert = node[:geminabox][:ssl][:cert]
  end

  {:key => geminabox_key, :cert => geminabox_cert}.each_pair do |key,val|
    file File.join(node[:nginx][:dir], "geminabox.ssl.#{key}") do
      content val
    end
    node.set[:geminabox][:ssl]["#{key}_file"] = File.join(node[:nginx][:dir], "geminabox.ssl.#{key}")
  end
end

template File.join('/', 'etc', 'nginx', 'sites-available', 'geminabox') do
  source 'nginx-geminabox.erb'
  variables(
    :socket => File.join(node[:geminabox][:base_directory], 'tmp/pids/puma.sock'),
    :root => node[:geminabox][:base_directory],
    :ssl => node[:geminabox][:ssl][:enabled],
    :ssl_cert => node[:geminabox][:ssl][:cert_file],
    :ssl_key => node[:geminabox][:ssl][:key_file],
  )
  mode '0644'
  notifies :restart, 'service[nginx]'
end

nginx_site 'default' do
  enable false
  notifies :restart, 'service[nginx]'
end

nginx_site 'geminabox' do
  enable true
  notifies :restart, 'service[nginx]'
end

# for app
directory "/srv/geminabox" do
  owner node[:geminabox][:directory][:owner]
  group node[:geminabox][:directory][:group]
  mode "0775"
  action :create
end
