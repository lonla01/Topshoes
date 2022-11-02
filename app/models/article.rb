require 'pathname'
require 'find'

class Article < ApplicationRecord
  
  @@host = "localhost"
  @@port = 3000
  
  def img_loc
    basename = Pathname.new(img).basename
    img_path = Pathname.new(category).join(basename)
    #img_url = "#{Article.local_base_url}/#{img_path}"
    img_path
  end

  def self.local_base_url
    "http://#{@@host}:#{@@port}"
  end

  def self.base_url
    "https://topshoes.herokuapp.com/"
  end

  
end
