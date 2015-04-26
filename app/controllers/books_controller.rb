class BooksController < ApplicationController
	helper :application

	# Global Variables
	before_action :deny_non_admins, except: [:index, :show, :search, :checkout]
	WillPaginate.per_page = 15

	def index
		@categories = {}
		books = Book.where deleted: false

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
		@books = Book.where id: params[:id]
		@books.update_all deleted: true

		redirect_to root_path
	end

	def search
		@books = Book.basic_search({
			 title: params[:search],
			 category: params[:search],
			 author: params[:search],
			 isbn: params[:search]},  false)

		@books = @books.paginate(page: params[:page])
		@books.per_page = 15
	end

	def checkout
		@first_book = Book.where title: 'Star Wars: A New Hope'
		@second_book = Book.where title: 'The Chicago Manual of Style'
	end

	private

	def deny_non_admins
		if !current_user || !current_user.is_role_by_name?('admin')
			redirect_to root_path
		end
	end

	def book_params
		params.require(:book).permit(
		 :isbn,
		 :quantity,
		 :title,
		 :author,
		 :summary,
		 :publisher,
		 :category,
		 :deleted,
		 :price)
	end

	def save_book book
		if book.save
			redirect_to book
		else
			render 'new'
		end
	end
end
