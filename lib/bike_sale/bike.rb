class BikeSale::Bike 
	attr_accessor :title, :price, :date_posted, :location, :url
	attr_reader :spec, :description

	@@all = []

	def initialize(attributes)
		attributes.each do |key, value|
				self.send("#{key}=", value)
		end
		@spec = []
		@description = []
		self.save
	end

	def save
		@@all << self
	end

	def self.all
		@@all 
	end

	def add_spec(spec_object)
		@spec << spec_object 
		spec_object.bike = self 
	end

	def add_description(description_object)
		@description << description_object
		description_object.bike = self 
	end

end