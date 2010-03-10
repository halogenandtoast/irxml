require 'rubygems'
require 'irxml'

IRXML.config = {:company_id => 'BHI', :pin => '18494309'}
puts IRXML::Stock.quote('BHI').inspect