module IRXML
  module Edgar
    class List
      def initialize
        get
        set_values
      end
      
      def get
        @data = IRXML.get('EdgarRTList', {'Version' => 2, 'OUTPUT' => 'xml'})
      end
      
      def documents
        @documents ||= []
      end
      
      def set_values
        @data.css('ROW').each do |node|
          documents << IRXML::Edgar::Document.new(node)
        end
      end
    end
    
    class Document
      def initialize(node)
        set_values(node)
      end
      
      def attributes
        @attributes ||= {}
      end
      
      def filing_url
        "http://investor.shareholder.com/#{IRXML.company_id.downcase}/secfiling.cfm?filingID=#{attributes['fid']}"
      end
      
      def set_values(node)
        node.children.each do |tag|
          attributes[tag.name.downcase] = tag.content
          self.class.class_eval { define_method(tag.name.downcase) { attributes[tag.name.downcase] } }
        end
      end
    end
  end
end