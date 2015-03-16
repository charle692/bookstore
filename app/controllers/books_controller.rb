class BooksController < ApplicationController
	helper :application

	before_action :deny_non_admins, except: [:index, :show]

	def index  
		@categories = {}
		books = Book.all

		books.each do |book|
			unless @categories.has_key? book.category 
				@categories[book.category] = []
			end

			@categories[book.category].append(book)
		end
	end

	def show 
		@book = Book.find(params[:id])
	end

	def new 
		@book = Book.new
	end

	def edit 
		@book = Book.find params[:id]
	end

	def create 
		@book = Book.new(book_params)

		if book2 = Book.find_by(isbn: @book.isbn) 
			book2.update_attribute "quantity", book2.quantity + @book.quantity
			redirect_to book2
		else
			get_book_cover @book.isbn
			save_book @book
		end
	end

	def update
		@book = Book.find params[:id]

		if @book.update(book_params)
			redirect_to @book
		else
			render 'edit'
		end
	end

	def destroy 
		@book = Book.find params[:id]
		@book.destroy

		redirect_to root_path
	end

	private 

	def deny_non_admins
		if !current_user || !current_user.is_role_by_name?('admin')
			redirect_to root_path
		end
	end

	def book_params 
		params.require(:book).permit(:isbn, :quantity, :title, :author, :summary, :publisher, :category)
	end

	# Gets book cover page
	def get_book_cover isbn
		File.open("/home/ryan/Dev/Rails_Development/bookstore/app/assets/images/#{isbn}.jpg", "wb") do |f|
			f.write(open("http://covers.librarything.com/devkey/KEY/medium/isbn/#{isbn}").read)
		end
	end

	def save_book book
		if book.save
			redirect_to book
		else
			render 'new'
		end
	end
end
