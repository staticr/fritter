class FollowConnection
  include Mongoid::Document

	field :follower_id
	field :followee_id
	
	index :follower_id
	index :followee_id
	
	def follower
		User.find(follower_id)
	end
	def follower= (usr)
		follower_id = usr._id
	end
	
	def follows
		User.find(followee_id)
	end
	def follows= (usr)
		followee_id = usr._id
	end
end
