class RenameGifToImage < ActiveRecord::Migration
  def change
    rename_table :gifs, :images
  end
end
