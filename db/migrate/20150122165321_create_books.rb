class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer :isbn
      t.integer :quantity

      t.timestamps
    end
  end
end
