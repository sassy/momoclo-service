require "open-uri"

module NewsHelper
  def parse_html
    doc = Nokogiri.HTML(open("http://www.momoclo.net/news/"));
    content = doc.css('h4').to_s
    content.gsub!("/pub/pc/", "http://www.momoclo.net/pub/pc/")
    content
  end
end
