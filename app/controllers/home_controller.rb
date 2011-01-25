class HomeController < ApplicationController
	before_filter :authenticate_user!, :only => %(home)
	
	before_filter :create_connection
	after_filter :drop_connection
	
  def index
		redirect_to 'home#home' if user_signed_in?
  end

	def home
		freet_list = @redis.lrange current_user._id, 0, 49
		#puts freet_list.inspect
		@freets = freet_list.collect { |id| Freet.criteria.id(id).first }
		#puts @freets.inspect
	end

end
