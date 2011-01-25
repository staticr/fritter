class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	field :nickname
	field :first_name
	field :last_name
	
	index :nickname

	references_many :freets
	
	def followers
		FollowConnection.find(:all, :conditions => {:followee_id => self._id}).collect { |f| f.follower }		
	end
	
	def following
		FollowConnection.find(:all, :conditions => {:follower_id => self._id}).collect { |f| f.follows }		
	end
end
