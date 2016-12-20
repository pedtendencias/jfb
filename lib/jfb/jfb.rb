require_relative 'rs'
require 'jdbc/firebird'

class JFB
	@con = nil
	@closed = true

	def initialize(db_url, usr, pwd)
		begin
			if Jdbc::Firebird.load_driver then
				@con = java.sql.DriverManager.getConnection(db_url, usr, pwd)
				puts 3

				@con.setAutoCommit false
				@con.setHoldability java.sql.ResultSet.HOLD_CURSORS_OVER_COMMIT
				@closed = false
			else
				puts "Failure to load driver."
			end

		rescue java.lang.Exception => erro
			@con = nil
			@closed = true
			puts "Error connecting!\n#{erro}"
		end
	end

	def query(cmd)
		if not @closed then
			begin
				return RS.new(@con.createStatement().executeQuery(cmd))
			rescue java.lang.Exception => erro
				puts "Error message:\n#{erro}"
			end
		end

		return nil
	end
	
	def update(cmd)
		if not @closed then
			begin
				@con.createStatement().executeUpdate(cmd)
			rescue java.lang.Exception => erro
				puts "Error message:\n#{erro}" 
			end
		else
			return nil
		end
	end

	def close
		if not @closed then
			@con.commit()
			@con.close()
			@con = nil
			@closed = true
		end
	end
end
