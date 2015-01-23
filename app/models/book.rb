class Book < ActiveRecord::Base
	# Makes sure that both an isbn and quantity are entered
	validates :isbn, :quantity, presence: true 
	validate :isbn_length

	private 
	def isbn_length
		unless isbn.size == 10 or isbn.size == 13
			errors.add(:isbn, "numbers must be 10 or 13 characters long #{isbn}")
		end
	end
end
