class BikeSale::Scraper 

	def self.scrape_bikes
		index_page = Nokogiri::HTML(open("https://boston.craigslist.org/d/bicycles/search/bia"))
binding.pry
		array_of_bikes = index_page.css()

	end


end