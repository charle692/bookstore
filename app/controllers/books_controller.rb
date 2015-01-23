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

			if @book.save
				redirect_to @book
			else
				render 'new'
			end
		else
			redirect_to books_path
		end
	end

	def update
		if logged_in?
			@book = Book.find(params[:id])

			# Using private book_params method
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
end
