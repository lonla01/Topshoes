class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :name
      t.integer :price
      t.integer :size
      t.string :category
      t.string :img
      t.string :color

      t.timestamps
    end
  end
end
