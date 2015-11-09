class BooksController < ApplicationController
	helper :application

	# Global Variables
	before_action :deny_non_admins, except: [:index, :show, :search, :checkout]
	WillPaginate.per_page = 15

	def index
		@categories = {}
		books = Book.where deleted: false

		books.first(100).each do |book|
			unless @categories.key? book.category
				@categories[book.category.name] = []
			end

			@categories[book.category.name].append(book)
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
			book2.update_attribute 'quantity', book2.quantity + @book.quantity
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
		@books = Book.joins(:category).basic_search(
		 categories: { name: params[:search] })

		(@books << Book.basic_search({
			 title: params[:search],
			 author: params[:search],
			 isbn: params[:search]},  false)).flatten!

		@books.each do |book|
			puts book.title
		end

		# Causing the array to get erased
		@books = @books.paginate(page: params[:page])
		puts @books.length
	end

	def checkout
		@first_book = Book.where title: 'The Chicago Manual of Style'
		@second_book = Book.where title: 'The Chicago Manual of Style'
	end

		private

	def deny_non_admins
		return false if current_user || current_user.is_role_by_name?('admin')
		redirect_to root_path
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
