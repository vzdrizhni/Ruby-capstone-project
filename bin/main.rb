require 'nokogiri'
require 'open-uri'

class Scrapper

    attr_reader :guitars

    def initialize (link)
        @link = link
        @doc = Nokogiri::HTML(open(@link))
        @product = @doc.css('.prodbtm')
        @guitars = []
    end

    def get_info
        @product.each_with_index do |elem, index|
            guitar = Hash.new(index)
            guitar['img_url'] = elem.css('img').attr('src').text
            guitar['title'] = elem.css('.product-title').text
            guitar['price'] = elem.css('.catPagePrice').text.delete "\n"
            @guitars << guitar
            @guitars
        end
    end
end

page = Scrapper.new('https://www.replayguitar.com/collections/electric-guitars')
page.get_info
p page.guitars