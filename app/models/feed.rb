class Feed < ActiveRecord::Base
  has_and_belongs_to_many :mixes
  validates_presence_of :url
  validates_uniqueness_of :name, :url
  validates_url_format_of :url

  after_validation_on_create :set_name_from_feed, :unless => :name?

  named_scope :not_in_mix, lambda {|mix| {:conditions => ['not exists (select 1 from feeds_mixes where feeds_mixes.mix_id = ? AND feeds_mixes.feed_id = feeds.id)', mix.id] } }
  
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
    @rss ||= RSS::Parser.parse(open(url), false)
  end
end
