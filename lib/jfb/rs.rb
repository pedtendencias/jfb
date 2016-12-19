require 'java'

java_import 'java.sql.ResultSet'

class RS
	def initialize(result_set)
		@my_rs = result_set
	end

	def absolute(row)
		@my_rs.absolute(row)
	end

	def next()
		return @my_rs.next()
	end

	def close()
		if not is_closed? then
			@my_rs.close()
		end
	end

	def is_closed? then
		return @my_rs.isClosed()
	end

	def is_last? then
		return @my_rs.isLast()
	end

	def is_first? then
		return @my_rs.isFirst()
	end

	def before_first then
		return @my_rs.beforeFirst()
	end

	def after_last then
		return @my_rs.afterLast()
	end

	def first then
		return @my_rs.first()
	end

	def last then
		return @my_rs.last()
	end

	def get_row
		return @my_rs.getRow()
	end
	
	def get_int(identifier)
		return @my_rs.getInt(identifier)
	end

	def get_double(identifier)
		return @my_rs.getDouble(identifier)
	end

	def get_string(identifier)
		return @my_rs.getString(identifier)
	end

	def get_date(identifier)
		return @my_rs.getDate(identifier)
	end
end
