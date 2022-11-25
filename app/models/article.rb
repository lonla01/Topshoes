require 'pathname'
require 'find'

class Article < ApplicationRecord
  
  @@host = "localhost"
  @@port = 3000
  
  def img_name
    Pathname.new(img).basename.to_s
  end

  def img_loc
    puts 'img_loc'
    puts 'Category: ' + category
    puts 'img: ' + img
    puts 'Img_name: ' + img_name
    Pathname.new('images').join(category, img_name)
  end
  
end
