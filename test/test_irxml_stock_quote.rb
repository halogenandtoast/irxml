require 'helper'

module TestIRXML
  module TestStock
    class TestQuote < Test::Unit::TestCase
      context "A StockQuote" do
        context "instance" do
          setup do 
            IRXML.expects(:get).with('StockQuote', 'TICKER' => IRXML.company_id).returns(Nokogiri::XML(File.read(File.dirname(__FILE__)+'/fixtures/stock_quote.xml')))
            @stock_quote = IRXML::Stock::Quote.new
          end
        
          should "respond to :attributes" do
            assert @stock_quote.respond_to?(:attributes)
          end
        
          should "respond to methods for each attribute" do
            @stock_quote.attributes.keys.each do |key|
              assert @stock_quote.respond_to?(key)
            end
          end
        end
      end
    end
  end
end