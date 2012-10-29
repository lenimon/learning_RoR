module ApplicationHelper
    def title
      base_title = "Ruby on Rails Tutorial Sample App"
      if @title.nil?
        base_title
      else
        "#{base_title} | #{@title}"
      end
    end

    def logo
      link_to image_tag('/royal.jpg', :alt=>'Sample App', :class=>'round'), root_path 
    end
end
