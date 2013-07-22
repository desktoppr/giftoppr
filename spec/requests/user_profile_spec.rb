require 'spec_helper'

describe "User Profile" do
  let(:user) { FactoryGirl.create(:user) }
  before { visit user_path(user) }

  context "as the user who owns the profile" do
    # before { sign_in(user) }
  
    it "should have the correct elements" do
      expect(page).to have_content("#{user.name}'s profile")
      expect(page).to have_link("Update my Gravatar", href: "http://gravatar.com")
    end
  end

  context "as some other user" do
    it "should have the correct elements" do
      expect(page).to have_content("#{user.name}'s profile")
      expect(page).to_not have_link("Update my Gravatar", href: "http://gravatar.com")
    end
  end
end