require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'is invalid without a name' do
    category = build(:category, name: nil)
    category.valid?
    expect(category.errors[:name].size).to eq(2)
  end
end
