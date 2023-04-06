require 'pathname'
require 'find'

class Article < ApplicationRecord
  
  @@host = "localhost"
  @@port = 3000
  
  def img_name
    puts "article.img=[#{img}]"
    result = Pathname.new(img).basename.to_s.sub! 'jpeg', 'jpeg'
    if result == nil 
      result = ""
    end
    result
  end

  def img_loc
    Pathname.new(img_name).basename.to_s
  end
  
end
