require 'helper'

module TestIRXML
  module TestEdgar
    class TestDocument < Test::Unit::TestCase
      context "An Edgar Document" do
        context "instance" do
          setup do 
            @nokogiri = Nokogiri::XML(File.read(File.dirname(__FILE__) + '/fixtures/edgar.xml'))
            IRXML.expects(:get).with('EdgarRTList', {'Version' => 2, 'OUTPUT' => 'xml'}).returns(@nokogiri)
            @list = IRXML::Edgar::List.new()
            @document = @list.documents[0]
          end
        
          should "respond to attributes" do
            assert @document.respond_to?(:attributes)
          end
          
          should "respond to filing_url" do
            assert @document.respond_to?(:filing_url)
          end
          
          should "have the correct filing_url" do
            assert_equal "http://investor.shareholder.com/#{IRXML.company_id.downcase}/secfiling.cfm?filingID=#{@nokogiri.css('FID')[0].content}", @document.filing_url
          end
        
        end
      end
    end
  end
end