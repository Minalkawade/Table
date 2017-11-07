class DeleteAvatarFormUser < ActiveRecord::Migration[5.1]
  def change
  	remove_attachment :users, :avatar
  end
end
