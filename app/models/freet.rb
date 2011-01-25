class Freet
  include Mongoid::Document

	field :body
	
	referenced_in :user
end
