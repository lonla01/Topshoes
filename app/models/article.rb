require 'pathname'
require 'find'

class Article < ApplicationRecord
  ALL_PRICES = [500, 1000, 1500, 2000, 2500, 3_000, 3_500, 4_000, 4_500, 5_000, 8_000, 9_000, 10_000, 12_000, 15_000,
                17_000, 19_000]
  ALL_SIZES_RANGE = 16...43
  ALL_SIZES = ALL_SIZES_RANGE.to_a
  ALL_DESCRIPTIONS = ['Petit Sac Bandoulière Arrondi Femme - Sac à Main Multi-Poches ',
                      'Eyecatch - Aux Femmes Faux Cuir Sac À Main Dames Épaule Sac',
                      'TLBag Sac à Main pour Femme avec Finitions Couleur Or',
                      'Tissé Paille Dames Sac Vintage Écharpe Sac À Main Plage Épaule',
                      'Retro Kiss Lock PU Cuir Chaînes minimaliste Crossbag Sac patchs ',
                      'Sac à Bandoulière pour Femme en Cuir Souple synthétique',
                      'Borsa donna Tracolla Crossbody M Romantica jacquard blu denim',
                      'Femme Mode Rainbow Fleurs Décorées La Paille Fourre-Tout Sac']

  def self.load_path
    # path = "/Users/patrice/Desktop/Developer/Projects/Topshoes/app/assets/images/Babouches1"
    # file_dir = File.dirname(__FILE__)
    file_dir = Rails.root.join('app', 'assets', 'images')
    puts "file_dir = #{file_dir}"
    return file_dir
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
    price_index = 0
    size_index = 0
    desc_index = 0

    puts "#{file_name} -> #{extract_category(file_name)}"
    article = Article.new
    article.name = file_name
    article.category = extract_category(file_name)
    article.price = ALL_PRICES[price_index%(ALL_PRICES.size)]
    article.size = ALL_SIZES[size_index%(ALL_SIZES.size)]
    #article.descriprion = ALL_DESCRIPTIONS[desc_index%(ALL_DESCRIPTIONS.size)]
    price_index += 1
    size_index += 1
    desc_index += 1
    article.img = Pathname.new(file_name).basename.to_s
    article.save
    return article
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
