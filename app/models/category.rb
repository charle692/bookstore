class Category < ActiveRecord::Base
  validates :name, presence: true, format: {
    with: /\A([a-zA-Z]|\p{Blank}|\W)+\z/,
    message: 'category can contain alphabetical characters'
  }
end
