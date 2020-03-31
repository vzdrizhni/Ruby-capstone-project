require_relative '../bin/main.rb'
require_relative '../lib/get_info.rb'

RSpec.describe Scrapper do

    let(:page) { Scrapper.new('https://www.replayguitar.com/collections/electric-guitars') }
    let(:first_result) { {"number"=>2, "img_url"=>"//cdn.shopify.com/s/files/1/1140/2426/products/Used-Epiphone-Korina-Explorer-Electric-Guitar-2003-Natural-15465_large.jpg?v=1585159281", "title"=>"Used 2003 Epiphone Korina Explorer, Natural", "price"=>"$399.99"} }
    let(:last_element) { {"number"=>356, "img_url"=>"//cdn.shopify.com/s/files/1/1140/2426/products/Gretsch-Duo-Jet-George-Harrison-Signature-3176_large.jpg?v=1571439052", "title"=>"Gretsch G6128T-GH George Harrison Duo Jet", "price"=>"$3,299.99"} }
    let(:wrong_last_element) { {"number"=>21, "img_url"=>"//cdn.shopify.com/s/files/1/1140/2426/products/Gibson-USA-Slash-Les-Paul-Standard-Electric-Guitar-Appetite-Amber-15097_large.jpg?v=1584459792", "title"=>"Gibson USA Slash Les Paul Standard, Appetite Amber", "price"=>"$2,999.00"} }

    describe '#initialize' do
        it 'should be the instance of the given class' do
            expect(page).to be_instance_of(Scrapper)
        end

        it 'should not be any instance of the class except Scrapper' do
            expect(page).not_to be_instance_of(String)
        end
    end

    describe '#guitars' do
        it 'should be an array of hashes and contain correct result values' do
            expect(page.guitars).to be_an(Array)
            expect(page.guitars.first).to eq(first_result)
            expect(page.guitars.last).to eq(last_element)
        end

        it 'should not be any type except an array and the last element shoud be correct' do
            expect(page.guitars).not_to be_a(String)
            expect(page.guitars).not_to eq(wrong_last_element)
        end
    end
end

RSpec.describe Info do

    let(:instance) { Info.new }
    let(:link) { 'https://www.replayguitar.com/collections/electric-guitars' }
    let(:first_result) { {"number"=>2, "img_url"=>"//cdn.shopify.com/s/files/1/1140/2426/products/Used-Epiphone-Korina-Explorer-Electric-Guitar-2003-Natural-15465_large.jpg?v=1585159281", "title"=>"Used 2003 Epiphone Korina Explorer, Natural", "price"=>"$399.99"} }
    let(:last_element) { {"number"=>356, "img_url"=>"//cdn.shopify.com/s/files/1/1140/2426/products/Gretsch-Duo-Jet-George-Harrison-Signature-3176_large.jpg?v=1571439052", "title"=>"Gretsch G6128T-GH George Harrison Duo Jet", "price"=>"$3,299.99"} }
    let(:wrong_last_element) { {"number"=>21, "img_url"=>"//cdn.shopify.com/s/files/1/1140/2426/products/Gibson-USA-Slash-Les-Paul-Standard-Electric-Guitar-Appetite-Amber-15097_large.jpg?v=1584459792", "title"=>"Gibson USA Slash Les Paul Standard, Appetite Amber", "price"=>"$2,999.00"} }

    describe '#get_info' do
        it 'should return correct first and last values' do
            expect(instance.get_info(18, link, []).first).to eq(first_result)
            expect(instance.get_info(18, link, []).last).to eq(last_element)
        end

        it 'should return correct values' do
            expect(instance.get_info(18, link, []).last).not_to eq(wrong_last_element)
            expect(instance.get_info(17, link, []).last).not_to eq(last_element)
        end
    end
end
