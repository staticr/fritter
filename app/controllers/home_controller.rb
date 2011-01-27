class HomeController < ApplicationController
	before_filter :authenticate_user!, :only => %(home)
	
	before_filter :create_connection
	after_filter :drop_connection
	
  def index
		redirect_to '/home' if user_signed_in?
  end

	def home
		@freets = (@redis.lrange current_user._id, 0, 49).collect { |id| Freet.criteria.id(id).first }
	end

end
