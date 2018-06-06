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
    "#{bottle_number} of beer on the wall, ".capitalize +
    "#{bottle_number} of beer.\n" +
    "#{bottle_number.action}, " +
    "#{bottle_number.successor} of beer on the wall.\n"
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
  def action
    'Go to the store and buy some more'
  end

  def successor
    BottleNumber.new(99)
  end

  def to_s
    'no more bottles'
  end
end

class BottleNumber1 < BottleNumber
  def action
    'Take it down and pass it around'
  end

  def to_s
    '1 bottle'
  end
end

class BottleNumber6 < BottleNumber
  def to_s
    '1 six-pack'
  end
end
