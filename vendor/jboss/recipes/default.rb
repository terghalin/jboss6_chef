#
# Cookbook Name:: jboss
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe "jboss::setup"
include_recipe "jboss::init"
include_recipe "jboss::deploy"
include_recipe "jboss::firewall"
