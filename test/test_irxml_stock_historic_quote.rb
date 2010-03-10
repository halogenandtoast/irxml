require 'helper'

module TestIRXML
  module TestStock
    class TestHistoricQuote < Test::Unit::TestCase
      context "A HistoricStockQuote" do
        context "instance" do
          setup do 
            @time = Time.now
            @nokogiri = Nokogiri::XML(File.read(File.dirname(__FILE__)+'/fixtures/historic_stock_quote.xml'))
            IRXML.expects(:get).with('HistoricStockQuote', {'TICKER' => IRXML.company_id, 'LOOKUPDATE' => CGI::escape(@time.strftime("%m/%d/%Y"))}).returns(@nokogiri)
            @stock_quote = IRXML::Stock::HistoricQuote.new(@time)
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