class BikeSale::CLI
	attr_accessor :sorted_bikes

	def start 
		puts "Welcome to the Boston Bike Sale CLI!".bold
		BikeSale::Scraper.scrape_bikes
		sort_bikes
		puts "Hit Enter when you're ready to see the most current bikes for sale on Boston Craigslist".bold
		input = gets.strip
		list_bikes
	end

	def sort_bikes
		@sorted_bikes = BikeSale::Bike.all.sort_by{|bike| bike.price.to_i}
	end

	def list_bikes
		puts "The bikes listed below are sorted from least expensive to most expensive:".bold
		@sorted_bikes.each.with_index(1) do |bike, index|
			puts "#{index}. #{bike.title.capitalize} - $#{bike.price}"
		end
		bike_details
	end

	def bike_details
		puts "\nPlease select the number of a bike you'd like to read more about:".bold
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
			puts "Sorry, that input cannot be found".colorize(:red).italic
			bike_details
		end
	end

	def main_menu(bike)
		puts "\nPlease select a number from the following options:".bold
		puts "1. Enter (1) to read a more detailed description of the selected bike"
		puts "2. Enter (2) to see the list of bikes again"
		puts "3. Enter (exit) to end CLI"
		input = gets.strip
		if input == "1"
			learn_more(bike)
		elsif 
			input == "2"
			list_bikes
		elsif  
			input == "exit" || input == "3"
			puts "Thank you for playing! Goodbye."
		else 
			puts "Sorry, that input cannot be found".colorize(:red).italic
			main_menu(bike) 
		end	
	end

	def learn_more(bike)
		get_specs(bike)
		get_description(bike)
		contact_seller(bike)
		puts "\nWould you like to see the list of bikes again? (Y/N)".bold
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
		puts "...fetching more information \n\n".italic
		puts "\n-----------------Bike Specs-----------------\n".bold
		BikeSale::Scraper.scrape_specs(bike)
		bike.spec.each do |bicycle|
			puts "	#{bicycle.bike_specs}"
		end
	end

	def get_description(bike)
		puts "\n-----------------Description-----------------\n".bold
		BikeSale::Scraper.scrape_description(bike)
		bike.description.each do |bicycle|
			puts "	#{bicycle.description}"
		end
	end

	def contact_seller(bike)
		puts "\n----Interested in purchasing this bike?-----".bold
		puts "Please follow contact instructions found at:" 
		puts "#{bike.url}".colorize(:blue)
	end

end