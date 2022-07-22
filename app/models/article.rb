require 'pathname'
require 'find'

class Article < ApplicationRecord
  
  @@host = "localhost"
  @@port = 3000
  
  def img_loc
    basename = Pathname.new(img).basename
    img_path = Pathname.new(category).join(basename)
    img_url = "http://#{@@host}:#{@@port}/#{img_path}"
    img_url
  end
  
end
