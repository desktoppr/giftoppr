FactoryGirl.define do
  factory :user do
    provider "dropbox"
    sequence(:uid)  { |n| n }
    sequence(:name)  { |n| "SomeName#{n}" }
    sequence(:email) {|n| "testuser#{n}@test.test" }
    oauth_token SecureRandom.hex
    oauth_secret SecureRandom.hex
  end
end