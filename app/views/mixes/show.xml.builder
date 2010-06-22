xml.instruct!
xml.rss("version" => "2.0") do
  xml.channel do
    xml.title h(@mix.name)
    xml.link "#{mix_url(@mix.friendly_id)}.xml"
    xml.description "A user-generated feed mix from progressivechristanvoices.com"
    xml.language "en-us"

    @mix.items.each do |item|
      xml.item do
        xml.pubDate item.pubDate.rfc822
        xml.title h(item.title)
        xml.description h(item.description)
        xml.enclosure(:url => item.enclosure.url, :length => item.enclosure.length, :type => item.enclosure.type)
      end
    end
  end
end

