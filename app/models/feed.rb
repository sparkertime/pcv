class Feed < ActiveRecord::Base
  validates_presence_of :name, :url
  validates_uniqueness_of :name, :url
  validates_url_format_of :url
  
  def url=(value)
    if value.nil? || value.include?('http://')
      super value
    else
      super "http://#{value}"
    end
  end

  def items
    [1]
  end
end
