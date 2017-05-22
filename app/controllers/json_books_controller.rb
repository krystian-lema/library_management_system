class JsonBooksController < ApplicationController
	skip_before_filter :verify_authenticity_token, :only => [:import_library_with_books, :import_library, :import_book]
  http_basic_authenticate_with name:"admin_code", password: "123654789"

  def import_library_with_books
  	# parse body send in json
		parsed_body = get_parsed_body

		# create array for import informations
		import_info_hashes = Array.new

		# add library
		library = import_library(parsed_body['library'])
		if library.save

			# add books
  		parsed_body['books'].each do |book|
  			import_info_hashes << import_book(book, library.id)
  		end
	  	# render info
	  	respond_to do |format|
		    format.json { 
		    	render json: {import_info_hashes: import_info_hashes}
		    }
	  	end

		else
			respond_to do |format|
		    format.json { 
		    	render json: {success: false, error: "Library cannot be created", details: library.errors.full_messages.first }
		    }
    	end
		end
	end

  def import_library(library_data)
  	return Library.new(
												name: library_data['name'],
												address: library_data['address'],
												description: library_data['description'],
												)
  end

  def import_book(book_data, library_id)
  	@book = Book.new(
  										title: book_data['title'],
  										author: book_data['author'],
  										edition: book_data['edition'],
  										publication_date: book_data['publication_date'],
  										ISBN: book_data['ISBN'],
  										signature: book_data['signature'],
  										library_id: library_id,
                      status: true
  										)
  	if @book.save
      return {success: true, book: @book}
    else
			return {success: false, error: "Book cannot be created.", details: @user.errors.full_messages.first, book: book_data}      
    end
  end

private

	def get_parsed_body
    request.body.rewind
    request_body = request.body.read
    if request_body.empty?
      request_body = '{}'
    end
    parsed_body = JSON.parse(request_body)
    parsed_body
  end	
end
