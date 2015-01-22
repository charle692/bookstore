class BooksController < ApplicationController
	def index  
		@books = Book.all
	end

	def show 
		# Passing id through the url
		@book = Book.find(params[:id])
	end

	def new 
	end

	def create 
		@book = Book.new(book_params)
		@book.save
		redirect_to @book
	end

	# Everything below this is a private method
	private 
	def book_params 
		params.require(:book).permit(:isbn, :quantity)
	end
end
