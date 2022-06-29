require 'pathname'
require 'find'

class Article < ApplicationRecord
  
  def img_loc
    basename = Pathname.new(img).basename
    img_root = Pathname.new('/').join(category, basename)
    img_root.to_s
  end
  
end
