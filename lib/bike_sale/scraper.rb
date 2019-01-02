class BikeSale::Scraper 

	def self.scrape_bikes
		index_page = Nokogiri::HTML(open("https://boston.craigslist.org/d/bicycles/search/bia"))
		array_of_bikes = index_page.css("ul.rows li.result-row")

		array_of_bikes.each do |bike_card|

			if bike_card.css(".result-title")[0] && bike_card.css(".result-price")[0] && bike_card.css(".result-date")[0] && bike_card.css(".result-hood")[0] && bike_card.css("a").attribute("href")
				attributes = {
					title: bike_card.css(".result-title")[0].text,
					price: bike_card.css(".result-price")[0].text.gsub("$",""),
					date_posted: bike_card.css(".result-date")[0].text,  
					location: bike_card.css(".result-hood")[0].text.gsub(/[()]/, "").strip,
					url: bike_card.css("a").attribute("href").value
				}
				bike = BikeSale::Bike.new(attributes)
			end

		end	

	end

	def self.scrape_more_info(bike)
		bike_specs = Nokogiri::HTML(open(bike.url))
		bike.spec = bike_specs.css("section.userbody div.mapAndAttrs p.attrgroup span").text
		bike.description = bike_specs.css("section.body #postingbody").text.gsub("QR Code Link to This Post", "").strip
	end
	
end