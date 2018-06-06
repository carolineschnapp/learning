class Bottles
  def song
    verses(99, 0)
  end

  def verses(upper, lower)
    upper.downto(lower).map { |i| verse(i) }.join("\n")
  end

  # #{quantity(number).to_s.capitalize} contains a hidden conditional: if a string already passes it, otherwise convert.
  def verse(number)
    bottle_number = BottleNumber.new(number)
    <<~VERSE
      #{bottle_number.quantity.capitalize} #{bottle_number.container} of beer on the wall, #{bottle_number.quantity} #{bottle_number.container} of beer.
      #{bottle_number.action}, #{bottle_number.successor.quantity} #{bottle_number.successor.container} of beer on the wall.
    VERSE
  end

  # Liskov substitution: 'if you make make a promise, keep it' (loose definition). Super strict-specific meaning:
  # If S is a subtype of T, then objects of type T may be replaced with objects of type S,
  # (i.e. an object of type T may be substituted with any object of a subtype S)
  # 'Principle of the least surprise' maybe?
  # Don't chase the shiny thing: one step at a time, one code smell at a time.

  def quantity(number)
    # if number == -1 # don't like this
    #   '99'
    if number == 0
      'no more'
    else
      number.to_s
    end
  end

  # Telling a story to someone slightly inebriated.
  # Guard clause is fo guarding, not for saving lines of code per say.
  def container(number) # def container(number = :FIXME)
    if number == 1 # the true should be more restricted
      'bottle'
    else # infinity of numbers
      'bottles'
    end
  end

  def pronoun(number) # def pronoun(number = :FIXME)
    if number == 1
      'it'
    else
      'one'
    end
  end

  def action(number)
    if number == 0
      'Go to the store and buy some more'
    else
      "Take #{pronoun(number)} down and pass it around"
    end
  end

  def successor(number)
    if number == 0
      99
    else
      number - 1
    end
  end
end

# Move all methods that obsess over an argument to a class
# that takes that aurgument as initializer, then the methods refer to it.
class BottleNumber
  def initialize(number)
    @number = number
  end

  def quantity
    if @number == 0
      'no more'
    else
      @number.to_s
    end
  end

  def container
    if @number == 1
      'bottle'
    else # infinity of numbers
      'bottles'
    end
  end

  def pronoun
    if @number == 1
      'it'
    else
      'one'
    end
  end

  def action
    if @number == 0
      'Go to the store and buy some more'
    else
      "Take #{pronoun} down and pass it around"
    end
  end

  def successor
    if @number == 0
      self.class.new(99)
    else
      self.class.new(@number - 1)
    end
  end
end

# 1. Not cache things. Object creation is free.
# 2. Make objects that are immutable.
# 3. If things are slow, benchmark it, don't make a guess as to which part is slow, you will likely have it wrong.
