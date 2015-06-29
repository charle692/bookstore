class RemoveBookIdFromCategory < ActiveRecord::Migration
  def change
    remove_column :categories, :book_id
  end
end
