require 'spec_helper'

describe MixesController do

  def mock_mix(stubs={})
    @mock_mix ||= mock_model(Mix, stubs)
  end

  describe "GET index" do
    it "assigns all mixes as @mixes" do
      mix1 = Factory(:mix, :name => 'zed')
      mix2 = Factory(:mix, :name => 'alpha')
      get :index
      assigns[:mixes].should == [mix2, mix1]
    end
  end

  describe "GET show" do
    it "assigns the requested mix as @mix" do
      Mix.stub(:find).with("37").and_return(mock_mix)
      get :show, :id => "37"
      assigns[:mix].should equal(mock_mix)
    end

    it "assigns feeds available for adding as @other_feeds" do
      mix = Factory(:mix, :feeds => [Factory(:feed)])
      feed = Factory(:feed)
      
      get :show, :id => mix.id

      assigns[:other_feeds].should == [feed]
    end
  end

  describe "GET new" do
    it "assigns a new mix as @mix" do
      Mix.stub(:new).and_return(mock_mix)
      get :new
      assigns[:mix].should equal(mock_mix)
    end
  end

  describe "GET edit" do
    it "assigns the requested mix as @mix" do
      Mix.stub(:find).with("37").and_return(mock_mix)
      get :edit, :id => "37"
      assigns[:mix].should equal(mock_mix)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created mix as @mix" do
        Mix.stub(:new).with({'these' => 'params'}).and_return(mock_mix(:save => true))
        post :create, :mix => {:these => 'params'}
        assigns[:mix].should equal(mock_mix)
      end

      it "redirects to the created mix" do
        Mix.stub(:new).and_return(mock_mix(:save => true))
        post :create, :mix => {}
        response.should redirect_to(mix_url(mock_mix))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved mix as @mix" do
        Mix.stub(:new).with({'these' => 'params'}).and_return(mock_mix(:save => false))
        post :create, :mix => {:these => 'params'}
        assigns[:mix].should equal(mock_mix)
      end

      it "re-renders the 'new' template" do
        Mix.stub(:new).and_return(mock_mix(:save => false))
        post :create, :mix => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested mix" do
        Mix.should_receive(:find).with("37").and_return(mock_mix)
        mock_mix.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :mix => {:these => 'params'}
      end

      it "assigns the requested mix as @mix" do
        Mix.stub(:find).and_return(mock_mix(:update_attributes => true))
        put :update, :id => "1"
        assigns[:mix].should equal(mock_mix)
      end

      it "redirects to the mix" do
        Mix.stub(:find).and_return(mock_mix(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(mix_url(mock_mix))
      end
    end

    describe "with invalid params" do
      it "updates the requested mix" do
        Mix.should_receive(:find).with("37").and_return(mock_mix)
        mock_mix.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :mix => {:these => 'params'}
      end

      it "assigns the mix as @mix" do
        Mix.stub(:find).and_return(mock_mix(:update_attributes => false))
        put :update, :id => "1"
        assigns[:mix].should equal(mock_mix)
      end

      it "re-renders the 'edit' template" do
        Mix.stub(:find).and_return(mock_mix(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested mix" do
      Mix.should_receive(:find).with("37").and_return(mock_mix)
      mock_mix.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the mixes list" do
      Mix.stub(:find).and_return(mock_mix(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(mixes_url)
    end
  end

  describe "POST add_feed" do
    before :each do
      @mix = Factory(:mix)
      @feed = Factory(:feed)
      
      post :add_feed, :id => @mix.friendly_id, :feed_id => @feed.id
    end

    it "should add a feed to a mix" do
      mix = Mix.find(@mix.id)
      mix.feeds.should include(@feed)
    end
    
    it "should redirect back to the mix show page" do
      response.should redirect_to(mix_url(@mix))
    end
  end

  describe "POST remove_feed" do
    before :each do
      @feed = Factory(:feed)
      @mix = Factory(:mix, :feeds => [@feed])

      post :remove_feed, :id => @mix.friendly_id, :feed_id => @feed.id
    end

    it "should remove the feed from the mix" do
      mix = Mix.find(@mix.id)
      mix.feeds.should_not include(@feed)
    end

    it "should redirect back to the mix show page" do
      response.should redirect_to(mix_url(@mix))
    end
  end
end
