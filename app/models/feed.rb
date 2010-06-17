class Feed < ActiveRecord::Base
  validates_presence_of :name, :url
  validates_uniqueness_of :name, :url
  validates_url_format_of :url
  
  def url=(value)
    super value if value.nil? || value.include?('http://')
    super "http://#{value}"
  end
end
