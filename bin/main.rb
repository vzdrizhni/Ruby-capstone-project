require_relative '../lib/get_info.rb'
require 'nokogiri'
require 'open-uri'

# rubocop:disable Security/Open
class Scrapper
  attr_reader :guitars

  def initialize(link)
    @link = link
    @doc = Nokogiri::HTML(open(@link))
    @product = @doc.css('.prodbtm')
    @max_page = @doc.css('.pagination-custom > li:nth-child(6) > a').text.to_i
    @guitars = []
    info = Info.new
    info.get_info(@max_page, @link, @guitars)
  end
end

page = Scrapper.new('https://www.replayguitar.com/collections/electric-guitars')
file_to_save = File.new('./saves/' + Time.now.strftime('%Y-%m-%d_%H-%M-%S') + '.txt', 'w+')
file_to_save.puts(page.guitars)
# rubocop:enable Security/Open
