module ApplicationHelper 

	def gravatar_for(user, options = { size: 80})
		gravatar_id=Digest::MD5::hexdigest(user.email.downcase)
		gravatar_url="https://secure.gravatar.com/avatar/02d9a355cf3efd492592f59b7dc5bb3c#{gravatar_id}"
		image_tag(gravatar_url,alt:user.username, class:"img-circle")
	end


end
  