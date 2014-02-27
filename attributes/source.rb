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

# define all dependencies before installing from source
default['rethinkdb']['src']['install_nodejs'] = true
default['rethinkdb']['src']['apt']['dependencies'] = %w(protobuf-compiler libprotobuf-dev libv8-dev libgoogle-perftools-dev libboost-all-dev libncurses5-dev)
default['rethinkdb']['src']['yum']['dependencies'] = %w(protobuf-compiler protobuf-devel v8-devel gperftools-devel boost-static ncurses-devel)

# source location
default['rethinkdb']['src']['dist_url'] = "http://download.rethinkdb.com/dist/"
default['rethinkdb']['src']['tar_filename'] = "rethinkdb-#{default['rethinkdb']['version']}.tgz"

# server locations
default['rethinkdb']['src']['path'] = '/usr/local/src'

# make configuration
default['rethinkdb']['src']['config_options'] = nil
