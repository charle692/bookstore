class AddAttributesToBooks < ActiveRecord::Migration
  def change
    add_column :books, :author, :string
    add_column :books, :summary, :string
    add_column :books, :publisher, :string
  end
end
