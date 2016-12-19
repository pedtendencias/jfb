require 'java'
require './rs'

java_import './FDBConnection.java'

class JFB
	def initialize(db_url, usr, pwd)
		begin
			@db = FFBConnection.new()
			@db.connectSQLServer(db_url, usr, pwd)
		rescue
			@db = nil
			@error = true
		end
	end

	def query(cmd)
		if @error then
			begin
				return RS.new(@db.makeQuery(cmd))
			rescue Error > erro
				puts "Error message:\n#{erro}"
			end
		end

		return nil
	end
	
	def update(cmd)
		if @error then
			begin
				@db.makeUpdate(cmd)
			rescue Error > erro
				puts "Error message:\n#{erro}" 
			end
		else
			return nil
		end
	end
end
