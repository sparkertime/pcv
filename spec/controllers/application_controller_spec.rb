require 'spec_helper'

describe ApplicationController do

  describe '.current_user' do
    it "should allow setting, retrieval of current user" do
      user = Factory.build(:user)
      controller.current_user = user
      controller.current_user.should == user
    end
  end

  describe ".logged_in?" do
    it "should be true when there is a current user" do
      controller.current_user = Factory(:user)
      controller.logged_in?.should be_true
    end

    it "should be false when there is not a current user" do
      controller.logged_in?.should be_false
    end
  end

end
