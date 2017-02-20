BASE_DIR = File.dirname(__FILE__)
$LOAD_PATH << BASE_DIR
Dir.chdir(BASE_DIR)

require 'rspec'
require 'watir'
require 'goulet.rb'