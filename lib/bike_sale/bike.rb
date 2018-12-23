class BikeSale::Bike 
	attr_accessor :title, :price, :date_posted, :location, :url
	attr_reader :details

	@@all = []

	def initialize(attributes)
		attributes.each do |key, value|
				self.send("#{key}=", value)
		end
		self.save
	end

	def save
		@@all << self
	end

	def self.all
		@@all 
	end

end