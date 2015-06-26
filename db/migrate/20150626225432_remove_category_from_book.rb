class RemoveCategoryFromBook < ActiveRecord::Migration
  def change
    remove_column :books, :category
  end
end
