require 'pathname'
require 'find'

ALL_PRICES = [500, 1000, 1500, 2000, 2500, 3_000, 3_500, 4_000, 4_500, 5_000, 8_000, 9_000, 10_000, 12_000, 15_000, 17_000, 19_000]
ALL_SIZES_RANGE = 16...43
ALL_SIZES = ALL_SIZES_RANGE.to_a
ALL_DESCRIPTIONS = ["Petit Sac Bandoulière Arrondi Femme - Sac à Main Multi-Poches ", 
  "Eyecatch - Aux Femmes Faux Cuir Sac À Main Dames Épaule Sac",
"TLBag Sac à Main pour Femme avec Finitions Couleur Or",
"Tissé Paille Dames Sac Vintage Écharpe Sac À Main Plage Épaule",
"Retro Kiss Lock PU Cuir Chaînes minimaliste Crossbag Sac patchs ",
"Sac à Bandoulière pour Femme en Cuir Souple synthétique",
"Borsa donna Tracolla Crossbody M Romantica jacquard blu denim",
"Femme Mode Rainbow Fleurs Décorées La Paille Fourre-Tout Sac"]

def load_path
  # path = "/Users/patrice/Desktop/Developer/Projects/Topshoes/app/assets/images/Babouches1"
  file_dir = File.dirname(__FILE__)

  puts "file_dir = #{file_dir}"

  file_dir
end

def invalid_dir?(file_name)
  (file_name == '.') or 
  (file_name == '..') or 
  (Pathname.new(file_name).basename.to_s.start_with? '.')
end

def supported_images_type? file_name
    supported =  ['', '.jpeg', '.png', '.gif', '.tiff']
    result = File.directory?(file_name) || supported.include?(File.extname(Pathname.new(file_name).basename.to_s))
    #puts "#{file_name} -> #{File.extname(file_name)} -> #{result}"
    return result
end

def extract_category(file_name)
  Pathname.new(file_name).parent.basename
end

def create_article(file_name)
  price_index = 0
  size_index = 0
  desc_index = 0
  puts "#{file_name} -> #{extract_category(file_name)}"
  article = Article.new
  article.name = file_name
  article.category = extract_category(file_name)
  article.price = ALL_PRICES[price_index++%(ALL_PRICES.size)]
  article.size = ALL_SIZES[size_index++%(ALL_SIZES.size)]
  article.descriprion = ALL_DESCRIPTIONS[desc_index++%(ALL_DESCRIPTIONS.size)]
  article.img = Pathname.new(file_name).basename.to_s
  return article
end

ALL_ARTICLES = []
def load_initial_articles
  Find.find(load_path) do |file|
    test_res = invalid_dir?(file) || !supported_images_type?(file)
    next if test_res
    next if File.directory? file

    ALL_ARTICLES << create_article(file) 
  end
end

load_initial_articles
puts "article count == #{ALL_ARTICLES.size}"
