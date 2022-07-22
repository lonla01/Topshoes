# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'pathname'
require 'find'
require 'uri'
require 'fileutils'

class Seed

  @@img_serial_num = 10000
  @@price_index = 0
  @@size_index = 0
  @@desc_index = 0

  ALL_PRICES = [500, 1000, 1500, 2000, 2500, 3_000, 3_500, 4_000, 4_500, 5_000, 8_000, 9_000, 10_000, 12_000, 15_000,
                17_000, 19_000]
  ALL_SIZES_RANGE = 16...43
  ALL_SIZES = ALL_SIZES_RANGE.to_a
  ALL_STOCKS = [0, 2, 5, 10, 20, 25, 30, 35, 40, 50]
  ALL_DESCRIPTIONS = ['Petit Sac Bandoulière Arrondi Femme - Sac à Main Multi-Poches ',
                      'Eyecatch - Aux Femmes Faux Cuir Sac À Main Dames Épaule Sac',
                      'TLBag Sac à Main pour Femme avec Finitions Couleur Or',
                      'Tissé Paille Dames Sac Vintage Écharpe Sac À Main Plage Épaule',
                      'Retro Kiss Lock PU Cuir Chaînes minimaliste Crossbag Sac patchs ',
                      'Sac à Bandoulière pour Femme en Cuir Souple synthétique',
                      'Borsa donna Tracolla Crossbody M Romantica jacquard blu denim',
                      'Femme Mode Rainbow Fleurs Décorées La Paille Fourre-Tout Sac']
  

                    
  def self.host
    @@host
  end

  def self.port
    @@port
  end

  def self.load_path
    # path = "/Users/patrice/Desktop/Developer/Projects/Topshoes/app/assets/images/Babouches1"
    # file_dir = File.dirname(__FILE__)
    file_dir = Rails.root.join('app', 'assets', 'images')
    puts "Rails.root = #{Rails.root}"
    puts "file_dir = #{file_dir}"
    file_dir
  end

  def self.invalid_dir?(file_name)
    (file_name == '.') or
      (file_name == '..') or
      (Pathname.new(file_name).basename.to_s.start_with? '.')
  end

  def self.supported_images_type?(file_name)
    supported = ['', '.jpeg', '.png', '.gif', '.tiff']
    File.directory?(file_name) || supported.include?(File.extname(Pathname.new(file_name).basename.to_s))
  end

  def self.extract_category(file_name)
    Pathname.new(file_name).parent.basename
  end

  def self.create_article(file_name)
    new_file_name = to_serial_num(file_name)
    category = extract_category(file_name)
    basename = Pathname.new(file_name).basename.to_s
    image_dir = Rails.root.join('public', category.to_s)
    # Create the parent folder if it doesn't exists.
    FileUtils.mkdir_p new_file_name.parent
    File.rename(file_name, new_file_name)

    puts "Old_file:[#{file_name}] -> New_file:[#{new_file_name}]"
    article = Article.new
    article.name = basename
    article.category = category
    article.price = ALL_PRICES[Random.rand(ALL_PRICES.size)]
    article.size = ALL_SIZES[Random.rand(ALL_SIZES.size)]
    article.description = ALL_DESCRIPTIONS[Random.rand(ALL_DESCRIPTIONS.size)]
    article.stock = ALL_STOCKS[Random.rand(ALL_STOCKS.size)]
    article.img = "#{image_dir.to_s}/#{Pathname.new(new_file_name).basename}"
    puts "article.img=[#{article.img}]"
    puts "article.img_loc=[#{article.img_loc}]"
    @@price_index += 1
    @@size_index += 1
    @@desc_index += 1
    @@img_serial_num += 1

    article.save
    article
  end

  def self.to_serial_num(file_name) 
    public_root = Rails.root.join('public')
    category = extract_category(file_name)
    path = Pathname.new(file_name)
    abs_path = Pathname.new(public_root.join(category, path.basename).expand_path.to_s)
    abs_path.to_s
  end

  def self.load_initial_articles
    puts 'Loading initial articles'
    all_articles = []
    Find.find(load_path.to_s) do |file|
      test_res = invalid_dir?(file) || !supported_images_type?(file)
      next if test_res
      next if File.directory? file

      all_articles << create_article(file)
    end
    puts "article count == #{all_articles.size}"
  end
end

Article.delete_all
Seed.load_initial_articles
