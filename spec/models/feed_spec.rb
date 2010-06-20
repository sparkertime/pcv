require 'spec_helper'
include RssFixture

describe Feed do
  describe "instance creation" do
    it "should create a new instance given valid attributes" do
      Feed.create!(Factory.attributes_for(:feed))
    end
  end

  describe "name" do

    it "should be unique" do
      feed1 = Factory(:feed)
      feed2 = Factory.build(:feed, :name => feed1.name)
      feed2.save

      feed2.errors.invalid?(:name).should be_true
    end
  end

  describe "url" do
    it "should be required" do
      feed = Factory.build(:feed, :url => nil)
      feed.save

      feed.errors.invalid?(:url).should be_true
    end

    it "should be unique" do
      feed1 = Factory(:feed)
      feed2 = Factory.build(:feed, :url => feed1.url)
      feed2.save

      feed2.errors.invalid?(:url).should be_true
    end

    it "should be a valid url" do
      feed = Factory.build(:feed, :url => 'hello')
      feed.save

      feed.errors.invalid?(:url).should be_true
    end

    it "should not require http in the url" do
      feed = Factory.build(:feed, :url => 'example.com')

      feed.url.should == 'http://example.com'
    end

    it "should not add http:// if present" do
      feed = Factory.build(:feed, :url => 'http://example.com')

      feed.url.should == 'http://example.com'
    end

    it "should update the name if it is not set on creation" do
      FakeWeb.register_uri(:get, rss_url, :body => rss)
      feed = Factory(:feed, :name => nil, :url => rss_url)

      feed.name.should == "Mars Hill Bible Church"
    end
  end

  describe "items" do
    before :each do      
      FakeWeb.register_uri(:get, rss_url, :body => rss)
      @feed = Factory.build(:feed, :url => rss_url)
    end

    it "should load the file from the url" do
      @feed.items.should be_present
    end

    it "should return all items in the feed when there is fewer than 10" do
      @feed.items.size.should == 12
    end

    it "should display a name for each item" do
      @feed.items.each do |item|
        item.title.should_not be_nil
      end
    end

    it "should display the first name correctly" do
      @feed.items.first.title.should == 'The Bud Before the Blossom'
    end

    it "should retrieve the enclosure" do
      @feed.items.first.enclosure.url.should == 'http://feedproxy.google.com/~r/marshill/podcast/~5/TLWoNAmyq_E/061310.mp3'
    end

    it "should retrieve the date correctly" do
      @feed.items.first.pubDate.should == Time.parse("Sun Jun 13 08:30:28 -0500 2010")
    end
  end
end
