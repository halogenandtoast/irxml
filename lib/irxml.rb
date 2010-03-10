require 'net/http'
require 'cgi'
require 'nokogiri'
require 'open-uri'

module IRXML
  extend self
  
  autoload :Stock, 'irxml/stock'
  autoload :Edgar, 'irxml/edgar'
  
  URI = 'apps.shareholder.com'
  BASE_PATH = '/irxml/irxml.aspx'
  
  def config
    @config ||= {}
  end
  
  def config=(hash)
    @config = hash
  end
  
  def company_id
    config[:company_id]
  end
  
  def company_id=(company_id)
    config[:company_id] = company_id
  end
  
  def pin=(pin)
    config[:pin] = pin
  end
  
  def get(function, params = {})
    Nokogiri::XML(open('http://' + IRXML::URI + IRXML::BASE_PATH + get_params(params.merge('FUNCTION' => function))))
  end
  
  private
  
  def get_params(params)
    '?' + default_params.merge(params).map{|key, value| "#{key}=#{value}"}.join('&')
  end
  
  def default_params
    {'COMPANYID' => config[:company_id], 'PIN' => config[:pin]}
  end
  
end