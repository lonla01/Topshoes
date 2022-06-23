class AddStockAndDescription < ActiveRecord::Migration[7.0]
  def up
    add_column :articles, :stock, :string
    add_column :articles, :description, :string
  end

  def down
    remove_column :articles, :stock, :string, if_exists: true
    remove_column :articles, :description, :string, if_exists: true
  end
end
