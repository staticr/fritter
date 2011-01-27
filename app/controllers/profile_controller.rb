class ProfileController < ApplicationController
	before_filter :load_user
	before_filter :authenticate_user!
	
  def show
		@is_current_user = @profile.nickname == current_user.nickname
		@is_following = false
		
		current_user.following.each { |f| @is_following = (f.nickname == @profile.nickname) || @is_following }
  end

	def follow
		FollowConnection.create! :followee_id => @profile._id, :follower_id => current_user._id unless @profile.nickname == current_user.nickname
		redirect_to("/profile/#{@profile.nickname}")
	end

	def unfollow
		FollowConnection.first(:conditions => {:followee_id => @profile._id, :follower_id => current_user._id}).delete
		redirect_to("/profile/#{@profile.nickname}")
	end
	
	protected
	
	def load_user
		@profile = User.first(:conditions => {:nickname => params[:nickname]})
	end
end
