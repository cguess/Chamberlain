class Client < ApplicationRecord

	before_create :generate_api_key

	def generate_api_key
		self.api_key = SecureRandom.base64(32)
	end

end
