#
# Cookbook Name:: emacs
# Recipe:: default
#
# Copyright 2009, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

node['emacs']['packages'].each do |pkg|

  package pkg do
    case node['platform']
    when "freebsd"
      source "ports"
      action :install
    else
      action :upgrade
    end
  end

end

node['emacs']['default_dot_users'].each  do |path|
  cookbook_file File.join(path, '.emacs') do
    source "dotemacs"
    owner File.basename(path)
    group File.basename(path)
    mode 00644
    action :create_if_missing
  end
end
