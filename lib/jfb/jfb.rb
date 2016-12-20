require_relative 'rs'
require 'jdbc/firebird'
java_import 'java.sql.DriverManager'
java_import 'java.sql.SQLRecoverableException'

class JFB
	@con = nil
	@closed = true

	def initialize(db_url, usr, pwd)
		begin
			if Jdbc::Firebird.load_driver then
				@con = DriverManager.getConnection(db_url, usr, pwd)

				@con.setAutoCommit false
				@con.setHoldability ResultSet.HOLD_CURSORS_OVER_COMMIT
				@closed = false
			else
				puts "Failure to load driver."
			end

		rescue SQLRecoverableException => erro
			@con = nil
			@closed = true
			puts "Error connecting!\n#{erro}"
		end
	end

	def query(cmd)
		if not @closed then
			begin
				return RS.new(@con.createStatement().executeQuery(cmd))
			rescue Error => erro
				puts "Error message:\n#{erro}"
			end
		end

		return nil
	end
	
	def update(cmd)
		if not @closed then
			begin
				@con.createStatement().executeUpdate(cmd)
			rescue Error => erro
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
