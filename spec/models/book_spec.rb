require 'spec_helper'

describe Book do
  it 'is invalid without a title' do
    book = build(:book, title: nil)
    book.valid?
    expect(book.errors[:title].size).to eq(2)
  end

  it 'is invalid without a category' do
    book = build(:book, category: nil)
    book.valid?
    expect(book.errors[:category].size).to eq(2)
  end

  it 'is invalid without a author' do
    book = build(:book, author: nil)
    book.valid?
    expect(book.errors[:author].size).to eq(2)
  end

  it 'is invalid without a publisher' do
    book = build(:book, publisher: nil)
    book.valid?
    expect(book.errors[:publisher].size).to eq(2)
  end

  it 'is invalid without a summary' do
    book = build(:book, summary: nil)
    book.valid?
    expect(book.errors[:summary].size).to eq(2)
  end

  it 'is invalid without a isbn' do
    book = build(:book, isbn: nil)
    book.valid?
    expect(book.errors[:isbn].size).to eq(2)
  end

  it 'is invalid without a price' do
    book = build(:book, price: nil)
    book.valid?
    expect(book.errors[:price].size).to eq(2)
  end

  it 'is invalid without a quantity' do
    book = build(:book, quantity: nil)
    book.valid?
    expect(book.errors[:quantity].size).to eq(2)
  end
end
