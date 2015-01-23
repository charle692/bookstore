class Book < ActiveRecord::Base
	# Makes sure that both an isbn and quantity are entered
	validates :isbn, length: { maximum: 13 }, :quantity, presence: true 
end
