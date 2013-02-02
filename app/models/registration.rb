module Registration
  def self.find_or_create_user_from_auth_hash(auth)
    user = User.find_by_provider_and_uid auth["provider"], auth["uid"].to_s

    unless user
      user = User.create! do |user|
        user.provider = auth["provider"]
        user.uid      = auth["uid"]
        user.name     = auth["info"]["name"]
        user.email    = auth["info"]["email"]
      end
    end

    user
  end
end
