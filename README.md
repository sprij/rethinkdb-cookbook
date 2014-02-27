rethinkdb-cookbook
==================
[![Build Status](https://secure.travis-ci.org/sprij/rethinkdb-cookbook.png)](http://travis-ci.org/sprij/rethinkdb-cookbook)
<br/><br/>Cookbook for [RethinkDB](http://rethinkdb.com/docs).

Requirements
==================
## Cookbooks
This cookbook depends on the following opscode community cookbooks:
 * apt 
 * yum
 * yum-epel
 * build-essentials
 * nodejs

## Platforms
The following families are supported by this cookbook:
 * Debian
 * RHEL
 * Fedora

Note that rethinkdb::package is only supported for Ubuntu and CentOS.

The integration tests cover the platforms:
 * Ubuntu 13.10
 * Debian 7.4
 * Centos 6.5
 * Fedora 19

Attributes
==================
This section describes available attributes.
##Default
Default attributes:
* **['rethinkdb']['install_method']**
    * Installation method
    * Default: package
    * Values: package or source
* **['rethinkdb']['version']**
    * Version to install
    * Default: 1.11.3

##Package
Attributes for the package recipe:
* **['rethinkdb']['package']['apt']['url']**
    * Default: http://ppa.launchpad.net/rethinkdb/ppa/ubuntu/
* **['rethinkdb']['package']['apt']['key_server']**
    * key server
    * Default: keyserver.ubuntu.com
* **['rethinkdb']['package']['apt']['key']**
    * key
    * Default: 11D62AD6
* **['rethinkdb']['package']['yum']['url']**
    * YUM repository
    * Default: "http://download.rethinkdb.com/centos/6/#{node['kernel']['machine']}"

##Source
Attributes that handle pre-requirements:
* **['rethinkdb']['src']['install_nodejs']**
    * Determines if nodejs cookbook will be used to install node and npm
    * Default: true
* **['rethinkdb']['src']['apt']['dependencies']**
    * Dependencies to install with APT
    * Default:
        * protobuf-compiler 
        * libprotobuf-dev 
        * libv8-dev 
        * libgoogle-perftools-dev 
        * libboost-all-dev 
        * libncurses5-dev
* **['rethinkdb']['src']['yum']['dependencies']**
    * Dependencies to install with YUM
    * Default:
        * protobuf-compiler 
        * protobuf-devel 
        * v8-devel
        * gperftools-devel 
        * boost-static 
        * ncurses-devel

Attributes related with remote and local paths: 
* **['rethinkdb']['src']['dist_url']**
    * Distributions URL
    * Default: http://download.rethinkdb.com/dist/
* **['rethinkdb']['src']['tar_filename']**
    * Filename to download
    * Default: "rethinkdb-#{default['rethinkdb']['src']['version']}.tgz"
* **['rethinkdb']['src']['path']** 
    * Path to download the source to.
    * Default: /usr/local/src

Attributes that control compiling the source code:
* **['rethinkdb']['src']['config_options']** 
    * Additional options to pass to ./config
    * Default: nil
    * If the default isn't changed '--dynamic tcmalloc_minimal' will be used
    for non-Debian platform families


Recipes
==================

This cookbook currently supports the following recipes:
* **rethinkdb**: installs rethinkdb
* **rethinkdb::package**: installs rethinkdb from package.
* **rethinkdb::source**: installs rethinkdb from source
