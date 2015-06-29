class AddBookIdToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :book_id, :integer
  end
end
