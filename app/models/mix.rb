class Mix < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  has_and_belongs_to_many :feeds, :uniq => true

  def items
    feeds.map {|f| f.items}.flatten.sort {|x,y| x.pubDate <=> y.pubDate }
  end
end
