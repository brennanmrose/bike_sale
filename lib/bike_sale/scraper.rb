class BikeSale::Scraper 

	def self.scrape_bikes
		index_page = Nokogiri::HTML(open("https://boston.craigslist.org/d/bicycles/search/bia"))

		array_of_bikes = index_page.css("ul.rows li.result-row")
		array_of_bikes[0..99].each do |bike_card|
			if bike_card.css(".result-title")[0] && bike_card.css(".result-price")[0] && bike_card.css(".result-date")[0] && bike_card.css(".result-hood")[0] && bike_card.css("a").attribute("href")
				attributes = {
					title: bike_card.css(".result-title")[0].text,
					price: bike_card.css(".result-price")[0].text,
					date_posted: bike_card.css(".result-date")[0].text,  
					location: bike_card.css(".result-hood")[0].text,
					url: bike_card.css("a").attribute("href").value
				}
				bike = BikeSale::Bike.new(attributes)
			end
		end	
	end

	def self.scrape_specs(bike)
		bike_specs = Nokogiri::HTML(open(bike.url))
		specs = bike_specs.css("section.userbody div.mapAndAttrs p.attrgroup span")
		specs.each do |spec|
			spec_object = BikeSale::BikeSpecs.new 
			spec_object.bike_specs = spec.text
			bike.add_spec(spec_object)
		end
	end

	# def self.scrape_specs(bike)
	# 	bike_specs = Nokogiri::HTML(open(bike.url))
	# 	array_of_specs = Array.new 
	# 	specs = bike_specs.css("section.userbody div.mapAndAttrs p.attrgroup span")
	# 	specs.each do |spec|
	# 		array_of_specs << spec.text
	# 	end
	# 	bike_description = bike_specs.css("section.body #postingbody")
	# 	bike_description.each do |paragraph|
	# 		array_of_specs << paragraph.text.gsub("QR Code Link to This Post", "")
	# 	end
	# 	array_of_specs
	# end

end
				# description: description.css("section.body #postingbody").text.strip