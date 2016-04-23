class AddFacebookAuthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fb_uid, :string
    add_column :users, :fb_token, :string
    add_column :users, :fb_raw_data, :text

    add_index :users, :fb_uid
  end
end
