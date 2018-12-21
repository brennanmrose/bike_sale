class BikeSale::CLI
	attr_accessor 

	def start 
		puts "Welcome to the Bike Sale CLI!"
		puts "Here are all of the current bikes for sale on Boston Craigslist:"
		BikeSale::Scraper.scrape_bikes
		list_bikes
	end

	def list_bikes
		BikeSale::Bikes.all.each.with_index(1) do |bike, index|
			puts 
			puts "#{index}. #{bike.title.capitalize}"
		end
	end

end