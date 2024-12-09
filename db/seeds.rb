Shelf.find_or_create_by!(name: 'Adventure')
Shelf.find_or_create_by!(name: 'Essays')
Shelf.find_or_create_by!(name: 'Biography')

shelf = Shelf.find_by(name: 'Adventure')

author = Author.find_or_create_by!(name: "Arthur Conan Doyle")
Book.find_or_create_by!(name: "The Hound of the Baskervilles", author:, shelf:)
Book.find_or_create_by!(name: "The Valley of Fear", author:, shelf:)

author = Author.find_or_create_by!(name: "J. R. R. Tolkien")
Book.find_or_create_by!(name: "The Hobbit", author:, shelf:)
Book.find_or_create_by!(name: "The Lord of the Rings", author:, shelf:)
Book.find_or_create_by!(name: "The Silmarillion", author:, shelf:)
