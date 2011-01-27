class BlurtController < ApplicationController
	before_filter :authenticate_user!
	
	before_filter :create_connection
	after_filter :drop_connection
	
	def create
		f = Freet.create!(:body => params[:blurt])
		current_user.freets << f

		@redis.lpush current_user._id, f._id
		current_user.followers.each { |r| @redis.lpush r._id, f._id }

		redirect_to("/home")
	end

end
