#
# Cookbook Name:: rethinkdb
# Attributes:: rethinkdb
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

default['rethinkdb']['package']['version'] = "1.11.3"
default['rethinkdb']['package']['apt']['url'] = "http://ppa.launchpad.net/rethinkdb/ppa/ubuntu/"
default['rethinkdb']['package']['apt']['key_server'] = "keyserver.ubuntu.com"
default['rethinkdb']['package']['apt']['key'] = "11D62AD6"

default['rethinkdb']['package']['yum']['url'] = "http://download.rethinkdb.com/centos/6/#{node['kernel']['machine']}"
