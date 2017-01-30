require_relative 'rs'
require_relative 'jaybird-2.2.10.jar'
java_import 'java.sql.ResultSet'
java_import 'java.sql.SQLRecoverableException'

class JFB
	@con = nil
	@closed = true

	def initialize(db_url, usr, pwd)
		Java::JavaClass.for_name("org.firebirdsql.jdbc.FBDriver")
		fbd = org.firebirdsql.jdbc.FBDriver.new

		if fbd.acceptsURL("jdbc:firebirdsql:#{db_url}") then
			Java::JavaClass.for_name("java.util.Properties")

			props = java.util.Properties.new
			props.set_property :user, usr
			props.set_property :password, pwd

			begin
				@con = fbd.connect("jdbc:firebirdsql:#{db_url}", props)
				@con.set_auto_commit false
				@con.set_holdability ResultSet.HOLD_CURSORS_OVER_COMMIT
				@closed = false

			rescue SQLRecoverableException => erro
				@con = nil
				@closed = true
				puts "Error connecting!\n#{erro}"
			end	
		else
			@con = nil
			@closed = true
			puts "Database URI #{db_url} isn't acceptable. 
			      You don't have to supply the 'jdbc:firebirsql:' part, 
			      we already do that. Please check your URI."
		end
	end

	def query(cmd)
		if not @closed then
			begin
				return RS.new(@con.createStatement().executeQuery(cmd))
			rescue Exception => erro
				puts "Error message:\n#{erro}"
			end
		end

		return nil
	end
	
	def update(cmd)
		if not @closed then
			begin
				@con.createStatement().executeUpdate(cmd)
			rescue Exception => erro
				puts "Error message:\n#{erro}" 
			end
		else
			return nil
		end
	end

	def commit
		if not @closed then
			@con.commit()
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
