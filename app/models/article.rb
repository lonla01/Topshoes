require 'pathname'
require 'find'

class Article < ApplicationRecord
  
  @@host = "localhost"
  @@port = 3000
  
  def img_name
    Pathname.new(img).basename.to_s.sub! 'jpeg', 'jpg'
  end

  def img_loc
    basename = Pathname.new(img).basename
    img_path = Pathname.new(category).join(basename)
    #img_url = "#{Article.local_base_url}/#{img_path}"
    img_path

    # Pathname.new(category).join(img_name)
  end
  
end
