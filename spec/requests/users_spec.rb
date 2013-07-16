require 'spec_helper'

describe "Users Spec" do
  let(:user) { FactoryGirl.create(:user) }
  subject { page }

  it "User should be able to view their profile page" do
    visit user_path(user)
    page.should have_content(user.name)
  end

end