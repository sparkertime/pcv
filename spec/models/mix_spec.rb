require 'spec_helper'

describe Mix do

  it "should create a new instance given valid attributes" do
    Mix.create!(Factory.attributes_for(:mix))
  end

  describe "name" do
    it "should be required" do
      mix = Factory.build(:mix, :name => nil)
      mix.save

      mix.errors.invalid?(:name).should be_true
    end

    it "should be unique" do
      mix1 = Factory(:mix)
      mix2 = Factory.build(:mix, :name => mix1.name)
      mix2.save

      mix2.errors.invalid?(:name).should be_true
    end
  end

  describe "feed association" do
    it "has multiple feeds" do
      mix = Factory(:mix)
      feed1 = Factory(:feed)
      feed2 = Factory(:feed)
  
      mix.feeds << feed1
      mix.feeds << feed2


      mix = Mix.find mix.id
      mix.feeds.should include(feed1)
      mix.feeds.should include(feed2)
    end
  end
end
