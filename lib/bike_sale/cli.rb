class BikeSale::CLI
	attr_accessor 

	def start 
		puts "Welcome to the Bike Sale CLI!"
		puts "Here are all of the current bikes for sale on Boston Craigslist:"
		BikeSale::Scraper.scrape_bikes
	end


end