require "spec_helper"

describe Jfb do
	before :all do
		@db = JFB.new('lnx-firebird://root/BDDS/SERIES.FDB', 'SYSDBA' , 'N3w0rd3r')
		@db.connect()
	end

  it "has a version number" do
    expect(Jfb::VERSION).not_to be nil
  end

	it "can query from a database" do
		h = @db.query("select * from setormacro")
		expect(h.class.to_s).to eq('Array')
		expect(h.size > 0).to eq(true)
	end

	after :all do
		@db.close()
	end
end
