class BikeSale::CLI
	attr_accessor 

	def start 
		puts "Welcome to the Bike Sale CLI!"
		BikeSale::Scraper.scrape_bikes
		list_bikes
		bike_details
		menu
	end

	def list_bikes
		puts "Here are all of the current bikes for sale on Boston Craigslist:"
		BikeSale::Bikes.all.each.with_index(1) do |bike, index|
			puts "\n#{index}. #{bike.title.capitalize}"
		end
	end

	def menu 
		puts "\nWhat would you like to do next? Please select a number from the following:"
		puts "1. Learn more about this bike"
			# learn_more
		puts "2. Select a different bike"
			# list_bikes
		puts "3. Contact seller" 
			# contact_seller
		puts "4. End CLI"
			# end_cli 
	end

	def bike_details
		puts "\nPlease select the number of a bike you'd like to read more about:"
		input = gets.strip
		index = input.to_i-1 
		if index.between?(0,5)
			bike = BikeSale::Bikes.all[index]
			puts "You have selected '#{bike.title}', posted on #{bike.date_posted}. This bike is priced at #{bike.price} and located near #{bike.location}."
			menu 
		elsif 
			input == "exit"
		else 
			puts "Sorry, that input cannot be found"
			bike_details
		end
	end

	def learn_more
		#second layer scrape
	end

	def contact_seller
		#provide url to page so user can see bike and contact seller
	end


end