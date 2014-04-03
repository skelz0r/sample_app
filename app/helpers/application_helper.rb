module ApplicationHelper

  def logo
    image_tag("logo.png", :alt => "Sample App", :class => "round")
  end

  # Return a title on a per-page basis.
  def title
    base_title = "Ruby on Rails Tutorial Sample App"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def error
    err = nil
    if @error == true
      "Error. Your registration failed. Please, check your information before submitting a sign up."
    else
      err
    end
  end

end
