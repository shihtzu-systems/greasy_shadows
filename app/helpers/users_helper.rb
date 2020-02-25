# frozen_string_literal: true

module UsersHelper
  # Returns the gravatar for the given user
  # rubocop:disable Style/ColonMethodCall
  def gravatar_for(user, options = { size: 80 })
    email = user&.email&.downcase || 'blah@blah.com'
    gravatar_id = Digest::MD5::hexdigest(email)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag gravatar_url, alt: user.name, class: 'gravatar'
  end
  # rubocop:enable Style/ColonMethodCall
end
