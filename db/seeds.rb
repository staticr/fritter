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

usr1 = User.first(:conditions => {:nickname => "user1"})

(1..10).each do |i| 
	f = Freet.create!(:body => "Hello, World #{i}")
	usr1.freets << f
	
	redis.lpush usr1._id, f._id
	usr1.followers.each { |r| redis.lpush r._id, f._id }
end

(1..4).each do |i|
	puts redis.llen(User.first(:conditions => {:nickname => "user#{i}"})._id.to_s)
end

redis.quit
