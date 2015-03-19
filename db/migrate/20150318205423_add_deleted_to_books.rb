class AddDeletedToBooks < ActiveRecord::Migration
  def change
    add_column :books, :deleted, :boolean
  end
end
