module ApplicationHelper
# Returns the full title on a per-page basis.
 def full_title page_title 
    base_title = I18n.t(".layouts.application.title_page")
    if page_title.blank?
      base_title
    else
      page_title + " | " + base_title
    end
 end
# Returns the Gravatar for the given user.
 def gravatar_for(user, options = { size: Settings.helper.size })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
