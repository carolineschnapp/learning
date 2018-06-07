# Duplication code smell.
# Remove duplication.
# Open? Not quite. But we further isolated what needs to be changed.
# Second code smell was 'conditionals'.
# Replace conditional with polymorphism.
# Edit one line of code at a time, then run tests, and they should be green.

require 'pry-byebug'

class Bottles
  def song
    verses(99, 0)
  end

  def verses(upper, lower)
    upper.downto(lower).map { |i| verse(i) }.join("\n")
  end

  # sub(pattern) {|match| block } → new_str
  # returns a copy of str with the first occurrence of pattern replaced by the second argument.

  def verse(number)
    BottleVerse.new(number).lyrics
  end
end

class BottleVerse
  attr_reader :number

  def initialize(number)
    @number = number
  end

  def lyrics
    bottle_number = BottleNumber.for(number)
    <<~VERSE
      #{bottle_number} of beer on the wall, #{bottle_number} of beer.
      #{bottle_number.action}, #{bottle_number.successor} of beer on the wall.
    VERSE
      .sub(/^./, &:upcase)
  end
end

class BottleNumber
  attr_reader :number

  class << self
    def for(number)
      registry.find { |candidate| candidate.handles?(number) }.new(number)

      # Hashes have a default value that is returned when accessing keys that do not exist in the hash.
      # Hash.new(BottleNumber).merge(
      #   0 => BottleNumber0,
      #   1 => BottleNumber1,
      #   6 => BottleNumber6,
      # )[number].new(number)

      # begin
      #   const_get("BottleNumber#{number}")
      # rescue NameError
      #   BottleNumber
      # end
      #   .new(number)

      # return number is number.is_a?(BottleNumber)
      # case number
      # when 0
      #   BottleNumber0
      # when 1
      #   BottleNumber1
      # when 6
      #   BottleNumber6
      # else
      #   BottleNumber
      # end
      #   .new(number)
    end

    def handles?(number)
      true
    end

    def registry
      @@registry ||= [BottleNumber]
    end

    def register(candidate)
      registry.unshift(candidate)
    end

    protected :new
  end

  def initialize(number)
    @number = number
  end

  # def initialize(number)
  #   @number = number
  # end

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
  register(self)

  def self.handles?(number)
    number == 0
  end

  def to_s
    'no more bottles'
  end

  def action
    'Go to the store and buy some more'
  end

  def successor
    BottleNumber.for(99)
  end
end

class BottleNumber1 < BottleNumber
  register(self)

  def self.handles?(number)
    number == 1
  end

  def to_s
    '1 bottle'
  end

  def action
    'Take it down and pass it around'
  end
end

class BottleNumber6 < BottleNumber
  register(self)

  def self.handles?(number)
    number == 6
  end

  def to_s
    '1 six-pack'
  end
end
