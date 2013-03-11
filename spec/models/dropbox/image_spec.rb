require 'spec_helper'

describe Dropbox::Image do
  describe "to_hash" do
    data = File.read(Rails.root.join('spec', 'fixtures', 'cat.jpg'))

    hash = Dropbox::Image.new(data, 'cat.png').to_hash

    hash[:height].should == 410
    hash[:width].should == 615
    hash[:bytes].should == 65347
    hash[:unique_hash].should == "519e353f2a0fda78421c9380deb273924a0fcee9"
    hash[:file].original_filename.should == "cat.png"
  end
end