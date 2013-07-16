require 'spec_helper'

describe User do
  
  describe "should respond to its attributes" do
    it { should respond_to(:provider) }
    it { should respond_to(:uid) }
    it { should respond_to(:name) }
    it { should respond_to(:email) }
    it { should respond_to(:oauth_token) }
    it { should respond_to(:oauth_token) }
    it { should respond_to(:created_at) }
    it { should respond_to(:updated_at) }
    it { should respond_to(:change_cursor) }
  end

  describe "should only allow valid attributes" do
    it { should validate_presence_of(:provider) }
    it { should validate_presence_of(:uid) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:oauth_token) }
    it { should validate_presence_of(:oauth_secret) }
  end

end