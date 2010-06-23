require 'spec_helper'

describe FeedsController do

  def mock_feed(stubs={})
    @mock_feed ||= mock_model(Feed, stubs)
  end

  describe "public actions" do

    describe "GET index" do
      it "assigns all feeds as @feeds" do
        feed = Factory(:feed)
        get :index
        assigns[:feeds].should == [feed]
      end
    end

    describe "GET show" do
      it "assigns the requested feed as @feed" do
        feed = Factory(:feed)
        get :show, :id => feed.id
        assigns[:feed].should == feed
      end
    end
  end

  describe "admin-only actions" do
    before :each do 
      ActionController::Routing::Routes.draw do |map|
        #part of the feeds controller is mapped strangely, so this helps rspec figure it out
        map.resources :feeds
      end 
    end
    
    before :each do
      make_authenticated
    end

    describe "GET new" do
      should_require_authentication :get, :new

      it "assigns a new feed as @feed" do
        get :new
        assigns[:feed].should_not be_nil
      end
    end

    describe "GET edit" do
      should_require_authentication :get, :edit, :id => "37"

      it "assigns the requested feed as @feed" do
        feed = Factory(:feed)
        get :edit, :id => feed.id
        assigns[:feed].should == feed
      end
    end

    describe "POST create" do
      should_require_authentication :post, :create, :feed => {}

      describe "with valid params" do
        it "assigns a newly created feed as @feed" do
          Feed.stub(:new).with({'these' => 'params'}).and_return(mock_feed(:save => true))
          post :create, :feed => {:these => 'params'}
          assigns[:feed].should equal(mock_feed)
        end

        it "redirects to the created feed" do
          Feed.stub(:new).and_return(mock_feed(:save => true))
          post :create, :feed => {}
          response.should redirect_to(feed_url(mock_feed))
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved feed as @feed" do
          Feed.stub(:new).with({'these' => 'params'}).and_return(mock_feed(:save => false))
          post :create, :feed => {:these => 'params'}
          assigns[:feed].should equal(mock_feed)
        end

        it "re-renders the 'new' template" do
          Feed.stub(:new).and_return(mock_feed(:save => false))
          post :create, :feed => {}
          response.should render_template('new')
        end
      end

    end

    describe "PUT update" do
      should_require_authentication :put, :update, :id => "37", :feed => {}

      describe "with valid params" do
        it "updates the requested feed" do
          Feed.should_receive(:find).with("37").and_return(mock_feed)
          mock_feed.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => "37", :feed => {:these => 'params'}
        end

        it "assigns the requested feed as @feed" do
          Feed.stub(:find).and_return(mock_feed(:update_attributes => true))
          put :update, :id => "1"
          assigns[:feed].should equal(mock_feed)
        end

        it "redirects to the feed" do
          Feed.stub(:find).and_return(mock_feed(:update_attributes => true))
          put :update, :id => "1"
          response.should redirect_to(feed_url(mock_feed))
        end
      end

      describe "with invalid params" do
        it "updates the requested feed" do
          Feed.should_receive(:find).with("37").and_return(mock_feed)
          mock_feed.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => "37", :feed => {:these => 'params'}
        end

        it "assigns the feed as @feed" do
          Feed.stub(:find).and_return(mock_feed(:update_attributes => false))
          put :update, :id => "1"
          assigns[:feed].should equal(mock_feed)
        end

        it "re-renders the 'edit' template" do
          Feed.stub(:find).and_return(mock_feed(:update_attributes => false))
          put :update, :id => "1"
          response.should render_template('edit')
        end
      end

    end

    describe "DELETE destroy" do
      should_require_authentication :delete, :destroy, :id => "37"

      it "destroys the requested feed" do
        feed = Factory(:feed)
        delete :destroy, :id => feed.id
        Feed.first(:conditions => {:id => feed.id}).should be_nil
      end

      it "redirects to the feeds list" do
        feed = Factory(:feed)
        delete :destroy, :id => feed.id
        response.should redirect_to(feeds_url)
      end
    end
  end
end
