require 'pathname'
require 'find'

class Article < ApplicationRecord
  
  @@host = "localhost"
  @@port = 3000
  
  def img_name
    Pathname.new(img).basename.to_s.sub! 'jpeg', 'jpg'
  end

  def img_loc
    Pathname.new('images').join(category, img_name)
  end
  
end
