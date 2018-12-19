require 'nokogiri'
require 'pry'
require 'open-uri'

require_relative "bike_sale/version"
require_relative "bike_sale/cli.rb"
require_relative "bike_sale/scraper.rb"
require_relative "bike_sale/bikes.rb"

module BikeSale
  class Error < StandardError; end
  # Your code goes here...
end

