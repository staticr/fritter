class ApplicationController < ActionController::Base
  protect_from_forgery

	def create_connection
		@conn = Redis.new
		puts @conn.inspect
	end
	
	def drop_connection
		@conn.quit if @conn
	end
end
