# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
require "redis"

redis = Redis.new

# Drop all redis keys
keys = redis.keys("*")
redis.multi do
	keys.each{ |k| redis.del k }
end

su = Admin.create! :email => 'root@fritter.local', :password => 'rootroot', :password_confirmation => 'rootroot'

(1..10).each { |i|
	User.create! :email => "user#{i}@fritter.local", :password => 'useruser', :password_confirmation => 'useruser', :nickname => "user#{i}"
}

(2..4).each { |i| 
	FollowConnection.create! :followee_id => User.first(:conditions => {:nickname => "user1"})._id, :follower_id => User.first(:conditions => {:nickname => "user#{i}"})._id	
}



redis.quit
