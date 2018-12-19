class BikeSale::Scraper 

	def self.scrape_bikes
		index_page = Nokogiri::HTML(open("https://boston.craigslist.org/d/bicycles/search/bia"))

		array_of_bikes = index_page.css("ul.rows")
			array_of_bikes.each do |bike_card|
				attributes = {
					title: bike_card.css(".result-title")[0].children.text,
					price: bike_card.css(".result-price")[0].children.text,
					date_posted: bike_card.css(".result-date")[0].children.text,  
					location: bike_card.css(".result-hood")[0].children.text
				}

			bike = BikeSale::Bikes.new(attributes)
		end
	end


end


# index_page.css("ul.rows").css(".result-title")[0].text