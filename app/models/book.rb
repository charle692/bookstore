class Book < ActiveRecord::Base
	# Makes sure that both an isbn and quantity are entered
	validates :isbn, :quantity, presence: true 
end
