class Movie

  REGULAR = 0
  NEW_RELEASE = 1
  CHILDRENS = 2

  attr_reader :title
  attr_accessor :price_code

  def initialize(title, price_code)
    @title = title
    @price_code = price_code
  end

end


class Rental
  attr_reader :movie, :days_rented

  def initialize(movie, days_rented)
    @movie = movie
    @days_rented = days_rented
  end
end

class Customer

  attr_reader :name

  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(arg)
    @rentals << arg
  end

  def statement
    total_amount = 0
    frequent_renter_points = 0

    result = "Rental Record for #{name}\n"

    @rentals.each do |rental|
      this_amount = 0

      # determins amounts for each line
      case rental.movie.price_code
      when Movie::REGULAR
        this_amount += 2
        this_amount += (rental.days_rented - 2) * 1.5 if rental.days_rented > 2
      when Movie::NEW_RELEASE
        this_amount += rental.days_rented * 3
      when Movie::CHILDRENS
        this_amount +=1.5
        this_amount (rental.days_rented - 3) * 1.5 if rental.days_rented > 3
      end

      #add frequent rentar points
      frequent_renter_points += 1
      # add bonus for a 2 day new release rental
      if rental.movie.price_code == Movie::NEW_RELEASE && rental.days_rented > 1
        frequent_renter_points += 1
      end

      #show figures for this rental

      result += "\t" + rental.movie.title + "\t" + this_amount.to_s + "\n"
      total_amount += this_amount
    end
    #add footer lines

    result += "Amount owed is #{total_amount} \n"
    result += "you have earned #{frequent_renter_points} points!"

    result
  end
end
