class ApplicationController < ActionController::Base
  protect_from_forgery

	def create_connection
		@redis = Redis.new
	end
	
	def drop_connection
		@redis.quit if @redis
	end
end
