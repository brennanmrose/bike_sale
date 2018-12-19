class BikeSale::Bikes 
	attr_accessor :title, :price, :date_posted, :location

	@@all = []

	def initialize(attributes_hash)
		attributes_hash.each do |key, value|
			self.send("#{key}=", value)
		end
		self.save
	end

	def save
		@@all << self
	end

	def self.all?
		@@all 
	end

end