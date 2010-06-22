module RssFixture

  def fake_rss_url(rss_name)
    @cache ||= {}
    @cache[rss_name.to_sym] ||= load_rss(rss_name)

    url = "http://fake.com/rss#{rss_name.to_s.underscore}"
    FakeWeb.register_uri(:get, url, :body => @cache[rss_name.to_sym])
    url
  end

  def load_rss(file_name)
    File.open(File.join(Rails.root, 'spec', 'rss_fixtures', "#{file_name.to_s}.xml")) do |f|
      return f.read
    end
  end
end
