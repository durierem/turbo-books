# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

author = Author.find_or_create_by!(name: "Arthur Conan Doyle")
Book.find_or_create_by!(name: "The Hound of the Baskervilles", author:)
Book.find_or_create_by!(name: "The Valley of Fear", author:)

author = Author.find_or_create_by!(name: "J. R. R. Tolkien")
Book.find_or_create_by!(name: "The Hobbit", author:)
Book.find_or_create_by!(name: "The Lord of the Rings", author:)
Book.find_or_create_by!(name: "The Silmarillion", author:)
