require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe "Rethinkdb Package installation" do

    it "rethinkdb package installed" do
        expect(package('rethinkdb')).should_not be_installed
    end

    it "rethinkdb package in path" do
        expect(file('/usr/local/bin/rethinkdb')).to be_file
    end
end
