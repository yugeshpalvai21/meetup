class Group < ApplicationRecord
	validates :name, presence: true
	validates :name, length: {minimum: 3, maximum: 12}

	before_save :to_lower

	def to_lower
		self.name = self.name.downcase
	end
end
