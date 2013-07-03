namespace :giftoppr do
  desc "Sync gifs from user accounts to giftoppr"
  task :sync => :environment do
    User.all.each do |user|
      Dropbox::Sync.sync_from_cursor user.id
    end
  end
end
