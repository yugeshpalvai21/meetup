class User < ApplicationRecord
	before_save :to_lower

	def to_lower
		self.first_name = self.first_name.to_s.downcase
		self.last_name = self.last_name.to_s.downcase
	end

	def full_name
		"#{self.first_name.capitalize} #{self.last_name.capitalize}"
	end
end
