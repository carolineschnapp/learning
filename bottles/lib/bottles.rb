require 'pry-byebug'

class Bottles
  def song
    verses(99, 0)
  end

  def verses(upper, lower)
    upper.downto(lower).map { |i| verse(i) }.join("\n")
  end

  def verse(number)
    bottle_number = BottleNumber.for(number)
    v = <<~VERSE
      #{bottle_number.to_s.capitalize} of beer on the wall, #{bottle_number} of beer.
      #{bottle_number.action}, #{bottle_number.successor} of beer on the wall.
    VERSE
  end
end

class BottleNumber
  attr_reader :number

  def self.for(number)
    case number
    when 0
      BottleNumber0
    when 1
      BottleNumber1
    when 6
      BottleNumber6
    else
      BottleNumber
    end
      .new(number)
  end

  def initialize(number)
    @number = number
  end

  def to_s
    "#{number} bottles"
  end

  def action
    'Take one down and pass it around'
  end

  def successor
    BottleNumber.for(number - 1)
  end
end

# Replace conditionals with polymorphism (inheritance)
# Replace conditionals with State/Strategy (composition) https://refactoring.guru/replace-type-code-with-state-strategy

class BottleNumber0 < BottleNumber
  def to_s
    'no more bottles'
  end

  def action
    'Go to the store and buy some more'
  end

  def successor
    BottleNumber.new(99)
  end
end

class BottleNumber1 < BottleNumber
  def to_s
    '1 bottle'
  end

  def action
    'Take it down and pass it around'
  end
end

class BottleNumber6 < BottleNumber
  def to_s
    '1 six-pack'
  end
end
