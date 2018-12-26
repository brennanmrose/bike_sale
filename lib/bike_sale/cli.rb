class BikeSale::CLI
	attr_accessor :sorted_bikes

	def start 
		puts "Welcome to the Bike Sale CLI!"
		BikeSale::Scraper.scrape_bikes
		sort_bikes
		list_bikes
	end

	def sort_bikes
		@sorted_bikes = BikeSale::Bike.all.sort_by{|bike| bike.price.to_i}
	end

	def list_bikes
		puts "Here is a list of the most current bikes for sale on Boston Craigslist:"
		@sorted_bikes.each.with_index(1) do |bike, index|
			puts "#{index}. #{bike.title.capitalize}"
		end
		bike_details
	end

	def bike_details
		puts "\nPlease select the number of a bike you'd like to read more about:"
		input = gets.strip
		index = input.to_i-1 
		if index.between?(0,@sorted_bikes.length-1)
			bike = @sorted_bikes[index]
			puts "You have selected '#{bike.title}', posted on #{bike.date_posted}. This bike is priced at $#{bike.price} and located near #{bike.location}."
			main_menu(bike) 
		elsif 
			input == "exit"
			puts "Thank you for playing! Goodbye."
		else 
			puts "Sorry, that input cannot be found."
			bike_details
		end
	end

	def main_menu(bike)
		puts "\nPlease select a number from the following options:"
		puts "1. Enter (1) to see the list of bikes again"
		puts "2. Enter (2) to read a more detailed description of your selected bike"
		puts "3. Enter (exit) to end CLI"
		input = gets.strip
		if input == "1"
			list_bikes
		elsif 
			input == "2"
			learn_more(bike)
		elsif  
			input == "exit" || input == "3"
			puts "Thank you for playing! Goodbye."
		else 
			puts "Sorry, that input cannot be found"
			main_menu(bike) 
		end	
	end

	def learn_more(bike)
		get_specs(bike)
		get_description(bike)
		puts "\nIf you are interested in purchasing this bike, please follow contact instructions found at #{bike.url}"
		puts "\nWould you like to see the list of bikes again? (Y/N)"
		input = gets.strip.upcase
		until ["Y","N","YES","NO"].include?(input)
			puts "Please type Y or N"
			input = gets.strip.upcase 
		end
		if input == "Y" || input == "YES"
				list_bikes
		else 
			puts "Thank you for playing! Goodbye."
		end	
	end

	def get_specs(bike)
		puts "...fetching bike specs \n\n"
		BikeSale::Scraper.scrape_specs(bike)
		bike.spec.each do |bicycle|
			puts "#{bicycle.bike_specs}"
		end
	end

	def get_description(bike)
		puts "...fetching description \n\n"
		BikeSale::Scraper.scrape_description(bike)
		bike.description.each do |bicycle|
			puts "#{bicycle.description}"
		end
	end

	def contact_seller
		#provide phone number (if provided) and email address
	end

end