class AddPictureToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :profile_picture, :string, default: ""
  end
end
