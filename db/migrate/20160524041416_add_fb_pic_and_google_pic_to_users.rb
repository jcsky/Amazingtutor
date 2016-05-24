class AddFbPicAndGooglePicToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fb_pic, :string
    add_column :users, :google_pic, :string
  end
end
