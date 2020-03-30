require 'nokogiri'
require 'open-uri'

class Scrapper

    attr_reader :guitars, :link

    def initialize (link)
        @link = link
        @doc = Nokogiri::HTML(open(@link))
        @product = @doc.css('.prodbtm')
        @max_page = @doc.css('#content > div > div > div.span9 > div.grid-item.pagination-border-top > div > div > div > ul > li:nth-child(6) > a').text.to_i
        @guitars = []
    end

    def get_info
        page_number = 1
        number = 1
        while page_number <= @max_page
            @link.concat("?page=#{page_number}")
            @doc = Nokogiri::HTML(open(@link))
            @product = @doc.css('.prodbtm')
            @product.each_with_index do |elem, index|
                guitar = Hash.new(index)
                guitar['number'] = number += 1
                guitar['img_url'] = elem.css('img').attr('src').text
                guitar['title'] = elem.css('.product-title').text
                guitar['price'] = elem.css('.catPagePrice').text.delete "\n"
                @guitars << guitar
            end
            @link = @link[0..56]
            page_number += 1
        end
    end
end

page = Scrapper.new('https://www.replayguitar.com/collections/electric-guitars')
page.get_info
puts page.guitars
#puts page.link
#p 'https://www.replayguitar.com/collections/electric-guitars'.length