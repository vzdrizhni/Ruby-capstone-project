require 'nokogiri'
require 'open-uri'

class Scrapper
    def initialize (link)
        @link = link
        @doc = Nokogiri::HTML(open(@link))
        @product = @doc.css('li.tiles__tile')
    end

    def print
        p @product
    end
end

page = Scrapper.new('https://reverb.com/marketplace/electric-guitars?condition=used&page=1')
page.print