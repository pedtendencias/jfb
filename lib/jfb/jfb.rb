require_relative 'jaybird-2.2.12.jar'
java_import 'java.sql.ResultSet'
java_import 'java.sql.SQLRecoverableException'

class JFB
	attr_accessor :closed

	def initialize(db_url, usr, pwd)
		Java::JavaClass.for_name("org.firebirdsql.jdbc.FBDriver")
		@fbd = org.firebirdsql.jdbc.FBDriver.new
		@url = db_url
		@usr = usr
		@pwd = pwd
		@closed = true
		@con = nil
	end

	def connect()
		if @closed then
			@con = nil

		if @fbd.acceptsURL("jdbc:firebirdsql:#{@url}") then
			Java::JavaClass.for_name("java.util.Properties")

			props = java.util.Properties.new
			props.set_property :user, @usr
			props.set_property :password, @pwd

			begin
				@con = @fbd.connect("jdbc:firebirdsql:#{@url}", props)
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
			puts "Database URI #{@url} isn't acceptable. 
			      You don't have to supply the 'jdbc:firebirsql:' part, 
			      we already do that. Please check your URI."
		end

			@closed = false
		end
	end

	def query(cmd)
		if not @closed then
			begin
				return convert_rs_to_array(@con.createStatement().executeQuery(cmd))
			rescue Exception => erro
				puts "Error message while querying:\n#{erro}\nQuery: #{cmd}"
			end
		end

		return nil
	end
	
	def update(cmd)
		if not @closed then
			begin
				@con.createStatement().executeUpdate(cmd)
			rescue Exception => erro
				puts "Error message while updating:\n#{erro}\nUpdate: #{cmd}" 
			end
		else
			return nil
		end
	end

	def commit
		if not @closed then
			begin
				@con.commit()
			rescue Exception => erro
				puts "Error message while commiting:\n#{erro}"
			end
		end
	end

	def close
		if not @closed then
			commit()

			begin
				@con.close()
			rescue Exception => erro
				puts "Error message while closing connection:\n#{erro}"
			end

			@con = nil
			@closed = true
		end
	end

	def convert_rs_to_array(rs)
		res = []
		k = 0

		cols = rs.get_meta_data.get_column_count

		while rs.next do
			(1..cols).each do |i|
				if res[k] == nil then
					res[k] = []
				end

				res[k][i - 1] = rs.get_string(i)	
			end

			k = k + 1
		end

		res
	end
end
