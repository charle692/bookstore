ActiveRecord::Schema.define(version: 20150306174450) do

  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'books', force: true do |t|
    t.string 'isbn'
    t.integer 'quantity'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.string 'author'
    t.text 'summary'
    t.string 'publisher'
    t.string 'title'
  end

  create_table 'users', force: true do |t|
    t.string 'username'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.string 'password_digest'
  end

end
