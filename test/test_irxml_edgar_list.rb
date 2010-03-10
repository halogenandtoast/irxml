require 'helper'

module TestIRXML
  module TestEdgar
    class TestList < Test::Unit::TestCase
      context "A StockQuote" do
        context "instance" do
          setup do 
            @nokogiri = Nokogiri::XML(File.read(File.dirname(__FILE__)+'/fixtures/edgar.xml'))
            IRXML.expects(:get).with('EdgarRTList', {'Version' => 2, 'OUTPUT' => 'xml'}).returns(@nokogiri)
            @list = IRXML::Edgar::List.new()
          end
        
          should "respond to documents" do
            assert @list.respond_to?(:documents)
          end
        
          should "have the correct number of documents" do
            assert_equal @nokogiri.css('ROW').count, @list.documents.length
          end
        end
      end
    end
  end
end