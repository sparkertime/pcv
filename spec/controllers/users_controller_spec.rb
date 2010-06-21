require 'spec_helper'

describe UsersController, :type => :controller do

  before :each do
    @user = Factory(:user)
    make_authenticated_as @user
  end

  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs)
  end
  

  describe "GET index" do
    should_require_authentication :get, :index

    it "assigns all users as @users" do
      get :index
      assigns[:users].size.should == 1
    end
  end

  describe "GET show" do
    should_require_authentication :get, :show, :id => "37"

    it "assigns the requested user as @user" do
      get :show, :id => @user.id
      assigns[:user].should  == @user
    end
  end

  describe "GET new" do
    should_require_authentication :get, :new

    it "assigns a new user as @user" do
      get :new
      assigns[:user].should_not be_nil
    end
  end

  describe "GET edit" do
    should_require_authentication :get, :edit, :id => "37"

    it "assigns the requested user as @user" do
      get :edit, :id => @user.id
      assigns[:user].should == @user
    end
  end

  describe "POST create" do
    should_require_authentication :post, :create, :user => {}

    describe "with valid params" do
      it "assigns a newly created user as @user" do
        User.stub(:new).with({'these' => 'params'}).and_return(mock_user(:save => true))
        post :create, :user => {:these => 'params'}
        assigns[:user].should equal(mock_user)
      end

      it "redirects to the created user" do
        User.stub(:new).and_return(mock_user(:save => true))
        post :create, :user => {}
        response.should redirect_to(user_url(mock_user))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        User.stub(:new).with({'these' => 'params'}).and_return(mock_user(:save => false))
        post :create, :user => {:these => 'params'}
        assigns[:user].should equal(mock_user)
      end

      it "re-renders the 'new' template" do
        User.stub(:new).and_return(mock_user(:save => false))
        post :create, :user => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do
    should_require_authentication :put, :update, :id => "37"

    describe "with valid params" do
      it "updates the requested user" do
        User.should_receive(:find).with("37").and_return(mock_user)
        mock_user.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :user => {:these => 'params'}
      end

      it "assigns the requested user as @user" do
        User.stub(:find).and_return(mock_user(:update_attributes => true))
        put :update, :id => "1"
        assigns[:user].should equal(mock_user)
      end

      it "redirects to the user" do
        User.stub(:find).and_return(mock_user(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(user_url(mock_user))
      end
    end

    describe "with invalid params" do
      it "updates the requested user" do
        User.should_receive(:find).with("37").and_return(mock_user)
        mock_user.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :user => {:these => 'params'}
      end

      it "assigns the user as @user" do
        User.stub(:find).and_return(mock_user(:update_attributes => false))
        put :update, :id => "1"
        assigns[:user].should equal(mock_user)
      end

      it "re-renders the 'edit' template" do
        User.stub(:find).and_return(mock_user(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    should_require_authentication :delete, :destroy, :id => "37"

    it "destroys the requested user" do
      user = Factory(:user)
      delete :destroy, :id => user.id
      User.first(:conditions => {:id => user.id}).should be_nil
    end

    it "redirects to the users list" do
      user = Factory(:user)
      delete :destroy, :id => user.id
      response.should redirect_to(users_url)
    end
  end

end
