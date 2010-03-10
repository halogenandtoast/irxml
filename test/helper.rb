require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'redgreen'
require 'mocha'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'irxml'

IRXML::pin = "12345678"
IRXML::company_id = "TEST"