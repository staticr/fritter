module ApplicationHelper
	def make_profile_url(nickname)
		"<a href='/profile/#{nickname}'>@#{nickname}</a>"
	end
end
