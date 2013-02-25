namespace :giftoppr do
  task :sync => :environment do
    User.all.each do |user|
      Dropbox::Sync.sync_from_cursor user.id
    end
  end
end
