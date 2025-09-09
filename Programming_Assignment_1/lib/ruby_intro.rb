# frozen_string_literal: true

# Part 1

def sum(arr)
  arr.reduce(0, :+)
end



def max_2_sum(arr)
  arr.max(2).sum
end

def sum_to_n?(arr, number)
  return false if arr.length < 2
  arr.combination(2).any? { |a, b| a + b == number }
end

# Part 2

def hello(name)
  "Hello, #{name}"
end


def starts_with_consonant?(string)
  string.match?(/\A[a-z&&[^aeiou]]/i)
end

def binary_multiple_of_4?(string)
  string.match?(/\A[01]+\z/) && string.to_i(2) % 4 == 0
end

# Part 3

# Object representing a book
class BookInStock
  
  attr_reader :isbn, :price

  def initialize(isbn, price)
    self.isbn = isbn
    self.price = price
  end

 
  def isbn=(new_isbn)
    raise ArgumentError, 'ISBN cannot be an empty string' if new_isbn.empty?
    @isbn = new_isbn
  end

  
  def price=(new_price)
    raise ArgumentError, 'Price must be greater than zero' if new_price <= 0
    @price = new_price.to_f
  end


  def price_as_string
    format('$%.2f', @price)
  end
end
