atom_feed do |feed|
  feed.title "Giftoppr"
  feed.updated @images.maximum(:updated_at)
  @images.each do |image|
    feed.entry(image, url: image.file) do |entry|
      entry.content "<img src=#{image.file} />", type: 'html'
      entry.title "New GIF: #{File.basename(image.file.to_s)}"
      entry.author do |author|
        author.name image.uploader.name
      end
    end
  end
end
