require 'java'

class RS
	def initialize(result_set)
		@my_rs = result_set
	end

	def absolute(row)
		@my_rs.absolute(row)
	end

	def next
		return @my_rs.next()
	end

	def previous
		return @my_rs.previous()
	end

	def close
		if not is_closed?
			@my_rs.close()
		end
	end

	def is_closed?
		return @my_rs.isClosed()
	end

	def is_last?
		return @my_rs.isLast()
	end

	def is_first? 
		return @my_rs.isFirst()
	end

	def before_first
		return @my_rs.beforeFirst()
	end

	def after_last
		return @my_rs.afterLast()
	end

	def first
		return @my_rs.first()
	end

	def last
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
