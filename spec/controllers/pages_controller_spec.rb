require 'spec_helper'

describe PagesController do

  describe "GET home" do
    it "should assign a list of recently created mixes in descending order" do
      mix1 = Factory(:mix, :created_at => Time.parse('12:55P'))
      mix2 = Factory(:mix, :created_at => Time.parse('12:58P'))

      get :home

      assigns[:mixes].should == [mix2, mix1]
    end

    it "should assign no more than 10 mixes" do
      11.times {Factory(:mix)}

      get :home

      assigns[:mixes].size.should == 10
    end
    
    it "should assign a list of recently created feeds in descending order" do
      feed1 = Factory(:feed, :created_at => Time.parse('12:55P'))
      feed2 = Factory(:feed, :created_at => Time.parse('12:58P'))

      get :home

      assigns[:feeds].should == [feed2, feed1]
    end

    it "should assign no more than 10 feeds" do
      11.times {Factory(:feed)}

      get :home

      assigns[:feeds].size.should == 10
    end
  end

end
