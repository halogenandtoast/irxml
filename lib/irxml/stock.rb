module IRXML
  module Stock
    class Quote
      def initialize(ticker = IRXML.company_id)
        get(ticker)
        set_values
      end
      
      def get(ticker)
        @data = IRXML.get('StockQuote', 'TICKER' => ticker)
      end
      
      def attributes
        @attributes ||= {}
      end
      
      def set_values
        @data.css('ROW').children.each do |node|
          attributes[node.name.downcase] = node.content
          self.class.class_eval { define_method(node.name.downcase) { attributes[node.name.downcase] } }
        end
      end
      
    end
    
    
    class HistoricQuote
      def initialize(lookupdate, ticker = IRXML.company_id)
        get(lookupdate, ticker)
        set_values
      end
      
      def get(lookupdate, ticker)
        lookupdate = CGI::escape(lookupdate.strftime("%m/%d/%Y"))
        @data = IRXML.get('HistoricStockQuote', {'TICKER' => ticker, 'LOOKUPDATE' => lookupdate})
      end
      
      def attributes
        @attributes ||= {}
      end
      
      def set_values
        @data.css('ROW').children.each do |node|
          attributes[node.name.downcase] = node.content
          self.class.class_eval { define_method(node.name.downcase) { attributes[node.name.downcase] } }
        end
      end
    end
    
  end
end