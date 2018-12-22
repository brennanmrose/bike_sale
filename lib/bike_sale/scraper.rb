class BikeSale::Scraper 

	def self.scrape_bikes
		index_page = Nokogiri::HTML(open("https://boston.craigslist.org/d/bicycles/search/bia"))

		array_of_bikes = index_page.css("ul.rows li.result-row")
		array_of_bikes[0..10].each do |bike_card|
			if bike_card.css(".result-title")[0] && bike_card.css(".result-price")[0] && bike_card.css(".result-date")[0] && bike_card.css(".result-hood") && bike_card.css("a").attribute("href")
				attributes = {
					title: bike_card.css(".result-title")[0].text,
					price: bike_card.css(".result-price")[0].text,
					date_posted: bike_card.css(".result-date")[0].text,  
					location: bike_card.css(".result-hood")[0].text,
					url: bike_card.css("a").attribute("href").value
				}
				bike = BikeSale::Bikes.new(attributes)
			end
		end	
	end

	def self.scrape_description(bike)
		description = Nokogiri::HTML(open(bike.url))
		binding.pry
	end

end