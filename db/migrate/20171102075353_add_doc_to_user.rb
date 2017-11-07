class AddDocToUser < ActiveRecord::Migration[5.1]
  def change
  	add_attachment :users, :document
  end
end
