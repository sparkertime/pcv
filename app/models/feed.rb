class Feed < ActiveRecord::Base
  validates_presence_of :url
  validates_uniqueness_of :name, :url
  validates_url_format_of :url

  after_validation_on_create :set_name_from_feed, :unless => :name?
  
  def url=(value)
    if value.nil? || value.include?('http://')
      super value
    else
      super "http://#{value}"
    end
  end

  def items
    @items = rss.items
  end

  private 

  def set_name_from_feed
    self.name = rss.channel.title
  end


  def rss
    @rss ||= RSS::Parser.parse open(url)
  end
end
