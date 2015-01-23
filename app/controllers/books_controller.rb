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

	def update
		@book = Book.find(params[:id])

		# Using private book_params method
		if @book.update(book_params)
			redirect_to @book
		else
			render 'edit'
		end
	end

	def destroy 
		# Want to add a check here to make sure the user is an admin
		@book = Book.find(params[:id])
		@book.destroy

		# Would like to post a successful delete message
		redirect_to books_path
	end

	# Everything below this is a private method
	private 
	def book_params 
		params.require(:book).permit(:isbn, :quantity)
	end
end
