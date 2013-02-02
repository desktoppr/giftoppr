class AddDropboxCursorToUser < ActiveRecord::Migration
  def change
    add_column :users, :change_cursor, :string
  end
end
