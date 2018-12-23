class BikeSale::CLI
	attr_accessor 

	def start 
		puts "Welcome to the Bike Sale CLI!"
		BikeSale::Scraper.scrape_bikes
		list_bikes
		bike_details
		menu(bike)
	end

	def list_bikes
		puts "Here are all of the current bikes for sale on Boston Craigslist:"
		BikeSale::Bike.all.each.with_index(1) do |bike, index|
			puts "\n#{index}. #{bike.title.capitalize}"
		end
	end

	def menu(bike)
		puts "\nWhat would you like to do next? Please select a number from the following:"
		puts "1. Learn more about this bike"
			learn_more(bike)
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
		if index.between?(0,99)
			bike = BikeSale::Bike.all[index]
			puts "You have selected '#{bike.title}', posted on #{bike.date_posted}. This bike is priced at #{bike.price} and located near #{bike.location}."
			menu(bike) 
		elsif 
			input == "exit"
		else 
			puts "Sorry, that input cannot be found"
			bike_details
		end
	end

	def learn_more(bike)
		BikeSale::Scraper.scrape_specs(bike)
		puts "Would you like to read more about this bike? (Y/N)"
		input = gets.strip.upcase
		until ["Y", "N", "YES", "NO"]
			puts "Please type Y or N"
			input = gets.strip.upcase
		end
		if input == "Y" || input == "YES"
			puts "...fetching description \n\n"
			puts BikeSale::Scraper.scrape_specs(bike)
			puts "If you are interested in purchasing this bike, please follow contact instructions found at #{bike.url}"
			# BikeSale::BikeSpecs.new(attributes)
		end
	end

	

	def contact_seller
		#provide url to page so user can see bike and contact seller
	end


end