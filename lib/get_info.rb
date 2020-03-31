require 'nokogiri'
require 'open-uri'

# rubocop:disable Security/Open
class Info
  def get_info(max_page, link, guitars)
    page_number = 1
    number = 1
    while page_number <= max_page
      link.concat("?page=#{page_number}")
      doc = Nokogiri::HTML(open(link))
      product = doc.css('.prodbtm')
      product.each_with_index do |elem, index|
        guitar = Hash.new(index)
        guitar['number'] = number += 1
        guitar['img_url'] = elem.css('img').attr('src').text
        guitar['title'] = elem.css('.product-title').text
        guitar['price'] = elem.css('.catPagePrice').text.delete "\n"
        guitars << guitar
      end
      link = link[0..56]
      page_number += 1
    end
  end
end
# rubocop:enable Security/Open
