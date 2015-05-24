class Book < ActiveRecord::Base  
  validates :price, presence: true, numericality: {
    only_float: true,
    message: 'must be of the following format: ##.##'
  }

  validates :quantity, presence: true, numericality: {
    only_integer: true,
    message: 'can only be a number'
  }

  validates :category, presence: true, format: {
    with: /\A([a-zA-Z]|\s)+\z/, message: 'can only be made of letters'
  }

  validates :title, :author, :summary, presence: true, format: {
    with: /\A(\w|\s|\p{Punct})+\z/,
    message: 'can only contain alphanumeric characters, spaces, and punctuation'
  }

  validate :isbn_length

	  private

	def isbn_length
    unless isbn.size == 10 || isbn.size == 13
  		errors.add(:isbn, "numbers must be 10 or 13 characters long #{isbn}")
    end
	end
end
