#
# Cookbook Name:: repose
# Recipe:: filter-http-logging
#
# Copyright (C) 2013 Rackspace Hosting
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'repose::install'

unless node['repose']['filters'].include? 'http-logging'
  filters = node['repose']['filters'] + ['http-logging']
  node.normal['repose']['filters'] = filters
end

template '/etc/repose/http-logging.cfg.xml' do
  owner 'repose'
  group 'repose'
  mode '0644'
  variables(
    :id => node['repose']['http_logging']['id'],
    :format => node['repose']['http_logging']['format'],
    :logfile => node['repose']['http_logging']['logfile']
  )
  notifies :restart, 'service[repose-valve]'
end