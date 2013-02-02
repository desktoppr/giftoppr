class CreateGifs < ActiveRecord::Migration
  def change
    create_table :gifs do |t|
      t.string   :file, :null => false
      t.integer  :width, :null => false
      t.integer  :height, :null => false
      t.string   :unique_hash, :null => false
      t.integer  :bytes, :null => false
      t.integer  :uploader_id, :null => false
      t.timestamps
    end

    add_index :gifs, :unique_hash
  end
end
