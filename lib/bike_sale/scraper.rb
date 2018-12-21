class BikeSale::Scraper 

	def self.scrape_bikes
		index_page = Nokogiri::HTML(open("https://boston.craigslist.org/d/bicycles/search/bia"))

		array_of_bikes = index_page.css("ul.rows li.result-row")
		array_of_bikes[0..5].each do |bike_card|
			attributes = {
				title: bike_card.css(".result-title")[0].text,
				# price: bike_card.css(".result-price")[0].text,
				date_posted: bike_card.css(".result-date")[0].text,  
				# location: bike_card.css(".result-hood")[0].text,
			}
			attributes.fetch(:title, "none_provided")
			attributes.fetch(:price, "none_provided")
			attributes.fetch(:date_posted, "none_provided") 
			attributes.fetch(:location, "none_provided") 

			bike = BikeSale::Bikes.new(attributes)
		end	
	end

end