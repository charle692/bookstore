class BooksController < ApplicationController
	def index  
		@categories = {}
		books = Book.all

		books.each do |book|
			unless @categories.has_key? book.category do
				@categories[book.category] = []
			end

			@categories[book.category].add(book)
		end
	end

	def show 
		# Passing id through the url
		@book = Book.find(params[:id])
	end

	def new 
		if logged_in?
			@book = Book.new
		else 
			redirect_to books_path
		end
	end

	def edit 
		if logged_in?
			@book = Book.find(params[:id])
		else
			redirect_to books_path
		end
	end

	def create 
		if logged_in?
			@book = Book.new(book_params)

			# Checks to see if a book exists yet or not
			if book2 = Book.find_by_isbn(@book.isbn)
				book2.update_attribute("quantity", book2.quantity + @book.quantity)
				redirect_to book2
			else
				save_book(@book)
			end
		else
			redirect_to books_path
		end
	end

	def update
		if logged_in?
			@book = Book.find(params[:id])

			if @book.update(book_params)
				redirect_to @book
			else
				render 'edit'
			end
		else
			redirect_to books_path
		end
	end

	def destroy 
		if logged_in?
			@book = Book.find(params[:id])
			@book.destroy

			# Would like to post a successful delete message
			redirect_to books_path
		else
			redirect_to books_path
		end
	end

	private 
	
	def book_params 
		params.require(:book).permit(:isbn, :quantity, :title, :author, :summary, :publisher, :category)
	end

	# Gets book cover page
	def get_book_cover (isbn)
		File.open("/home/ryan/Dev/Rails_Development/bookstore/app/assets/images/#{isbn}.jpg", "wb") do |f|
			f.write(open("http://covers.librarything.com/devkey/KEY/medium/isbn/#{isbn}").read)
		end
	end

	def save_book(book)
		get_book_cover book.isbn
		if book.save
			redirect_to book
		else
			render 'new'
		end
	end
end
