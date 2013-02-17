DROPBOX_PATH = File.expand_path "~/Dropbox/Apps/Giftoppr"

users = if User.count > 0
          User.all.to_a
        else
          %w(keithpitt mariovisic).map do |username|
            User.create! :provider => 'dropbox', :uid => Time.now.to_i, :name => username, :email => "#{username}@example.com", :oauth_token => 'hello', :oauth_secret => 'hello'
          end
        end

gifs = Dir[File.join DROPBOX_PATH, "*"]

gifs.each do |path|
  size = FastImage.size(path)

  if size
    unique_hash = `md5 -r "#{path}"`.split(' ')[0]

    gif =  Gif.new :file => File.new(path), :width => size[0], :height => size[1], :unique_hash => unique_hash, :bytes => File.size(path)
    gif.uploader = users.sample
    gif.save!

    p gif
  else
    puts "Could not calculate size for #{path}"
  end
end
