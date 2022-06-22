class CreateInitialArticles < ActiveRecord::Migration[7.0]

  def up
    Article.load_initial_articles
  end

  def down
    Article.delete_all
  end

end
