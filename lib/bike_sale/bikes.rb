class BikeSale::Bikes 
	attr_accessor

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