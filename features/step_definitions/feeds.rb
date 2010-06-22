Given /^I have the feed(?:s?)$/ do |table|
  table.map_headers!{ |header| header.downcase.to_sym }
  table.hashes.each do |attributes|
    url_name = attributes[:name].gsub(/ /, '_')
    Factory(:feed, :name => attributes[:name], :url => fake_url(url_name))
  end
end
