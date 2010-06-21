require 'spec_helper'

describe User do
  it "should create a new instance given valid attributes" do
    User.create!(Factory.attributes_for(:user))
  end

  describe "name" do
    it "should be unique" do
      user1 = Factory(:user)
      user2 = Factory.build(:user, :name => user1.name)
      user2.save

      user2.errors.invalid?(:name).should be_true
    end

    it "should be required" do
      user = Factory.build(:user, :name => nil)
      user.save

      user.errors.invalid?(:name).should be_true
    end
  end

  describe "password" do
    it "should be required" do
      user = Factory.build(:user, :password => nil)
      user.save

      user.errors.invalid?(:password).should be_true
    end

    it "should require confirmation" do
      user = Factory.build(:user, :password_confirmation => nil)
      user.save
      
      user.errors.invalid?(:password_confirmation).should be_true
    end

    it "should require correct confirmation" do
      user = Factory.build(:user, :password_confirmation => 'adasd')
      user.save

      user.errors.invalid?(:password).should be_true
    end

    it "should require at least one letter" do
      user = Factory.build(:user, :password => '123!', :password_confirmation => '123')
      user.save
      
      user.errors.invalid?(:password).should be_true
    end

    it "should require at least one number" do
      user = Factory.build(:user, :password => 'abc!', :password_confirmation => 'abc!')
      user.save

      user.errors.invalid?(:password).should be_true
    end

    it "should require at least one symbol" do
      user = Factory.build(:user, :password => 'abc123', :password_confirmation => 'abc123')
      user.save

      user.errors.invalid?(:password).should be_true
    end

    it "should not contain spaces" do
      user = Factory.build(:user, :password => 'a ! 1', :password_confirmation => 'a ! 1')
      user.save
      
      user.errors.invalid?(:password).should be_true
    end    
  end
end
