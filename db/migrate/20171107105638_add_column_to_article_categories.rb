class AddColumnToArticleCategories < ActiveRecord::Migration[5.1]
  def change
  	add_column :article_categories, :article_id, :integer
  	add_column :article_categories, :category_id, :integer
  end
end
