class BooksController < ApplicationController
	def index  
		@books = Book.all
	end

	def show 
		# Passing id through the url
		@book = Book.find(params[:id])
	end

	def new 
		@book = Book.new
	end

	def edit 
		@book = Book.find(params[:id])
	end

	def create 
		@book = Book.new(book_params)

		if @book.save
			redirect_to @book
		else
			render 'new'
		end
	end

	# Everything below this is a private method
	private 
	def book_params 
		params.require(:book).permit(:isbn, :quantity)
	end
end
