module RssFixture
  def rss
    File.open(File.join(Rails.root, 'spec', 'rss_fixtures', 'mars_hill.xml')) do |f|
      return f.read
    end
  end

  def rss_url
    'http://fake.com/rss'
  end
end
