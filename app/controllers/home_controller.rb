class HomeController < ApplicationController
	before_filter :create_connection
	after_filter :drop_connection
	
  def index
		@conn.set 'foo', 'bar'
  end

end
