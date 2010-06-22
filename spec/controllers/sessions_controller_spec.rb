require 'spec_helper'

describe SessionsController do

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST 'create'" do
   
    describe "on success" do
      before :each do
        @user = Factory(:user)
        post :create, :username => @user.name, :password => @user.password
      end

      it "should login the user" do
        controller.current_user.should == @user
      end

      it "should redirect to the feeds" do
        response.should redirect_to(feeds_path)
      end
    end

    describe "on failure" do
      before :each do
        @user = Factory(:user)
        post :create, :username => 'bah', :password => 'boo'
      end

      it "should not login the user" do
        controller.logged_in?.should be_false
      end

      it "should return to the login page" do
        response.should redirect_to(new_session_path)
      end
    end
  end
end
