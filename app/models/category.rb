class Category < ActiveRecord::Base
  has_many :books

  validates :name, presence: true, format: {
    with: /\A([a-zA-Z]|\p{Blank}|\W)+\z/,
    message: 'category can contain alphabetical characters'
  }
end
