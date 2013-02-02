class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider, :null => false
      t.string :uid, :null => false
      t.string :name, :null => false
      t.string :email, :null => false
      t.string :oauth_token, :null => false
      t.string :oauth_secret, :null => false

      t.timestamps
    end

    add_index :users, [ :provider, :uid ]
  end
end
