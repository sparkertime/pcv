class Mix < ActiveRecord::Base
  has_friendly_id :name, :use_slug => true, :approximate_ascii => true, :max_length => 50
  

  validates_presence_of :name
  validates_uniqueness_of :name

  has_and_belongs_to_many :feeds, :uniq => true

  def items
    feeds.map {|f| f.items}.flatten.sort {|x,y| x.pubDate <=> y.pubDate }
  end
end
