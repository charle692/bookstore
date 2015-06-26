FactoryGirl.define do
  factory :book do
    isbn Faker::Code.isbn
    author Faker::Name.name
    summary Faker::Lorem.paragraph
    publisher Faker::Company.name
    title Faker::Name.name
    price Faker::Commerce.price
    quantity 1
    deleted false
  end
end
