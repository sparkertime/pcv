module AuthenticationMacros
  def make_authenticated
    make_authenticated_as Factory(:user)
  end

  def make_authenticated_as(user)
    session[:user_id] = user.id
  end

  def should_require_authentication(verb, action, parameters = {})
    it "should require authentication" do
      controller.current_user = nil
      send(verb, action, parameters)

      response.should redirect_to(new_session_url)
      flash[:error].should == "This action is available to administrators only"
    end
  end
end
