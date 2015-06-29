class Book < ActiveRecord::Base
  belongs_to :category

  validates :price, presence: true, numericality: {
    only_float: true,
    message: 'must be of the following format: ##.##'
  }

  validates :quantity, presence: true, numericality: {
    only_integer: true,
    message: 'can only be a number'
  }

  validates :title, :author, :publisher, :summary, presence: true, format: {
    with: /\A(\w|\s|\p{Punct}|\W)+\z/,
    message: 'can\'t contain special characters'
  }

  validates :isbn, presence: true, format: {
    with: /\A((\d{9}\-\d))|(\d{3}\-\d\-\d{2}\-\d{6}\-\d)\z/,
    message: 'must be in the following format xxxxxxxxx-x or ' +
     'xxx-x-xx-xxxxxx-x and can only contain numbers'
  }
end
