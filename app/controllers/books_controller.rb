class BooksController < ApplicationController
	def index  
		@books = Book.all
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

	# Everything below this is a private method
	private 
	def book_params 
		params.require(:book).permit(:isbn, :quantity)
	end

	# Gets book cover page
	def get_book_cover (isbn)
		File.open("/home/ryan/Dev/Rails_Development/bookstore/app/assets/images/#{isbn}.jpg", "wb") do |f|
			f.write(open("http://covers.librarything.com/devkey/KEY/medium/isbn/#{isbn}").read)
		end
	end

	def save_book(book)
		get_book_cover book.isbn
		get_book_info book
		if get_book_info(book).save
			redirect_to book
		else
			render 'new'
		end
	end

	# Gets book information 
	def get_book_info(book) 
		# This does not return anything right now
		results = ISBNdb::Query.find(:collection => 'books', :where => { :isbn => format_isbn(book.isbn) })
		p "results : #{results}"

		results.each do |result| 
			puts "title: #{result.title}"
			book.assign_attributes(title: "#{result.title}", author: "#{result.authors_text}", summary: "#{result.book_summary}", publisher: "#{result.publisher_name}")
		end

		return book
	end

	def format_isbn (isbn) 
		formatted_isbn = "978-#{isbn[0]}-#{isbn[1..4]}-#{isbn[5..8]}-#{isbn[9]}"
	end
end
