class Integer
  def to_bottle_number
    BottleNumber.for(self)
  end
end

def BottleNumber(number)
  return number if number.kind_of?(BottleNumber)
  BottleNumber.for(number)
end

class DescendingVerseSong
  attr_reader :verse_template, :upper, :lower

  def initialize(verse_template: BottleVerse, upper: 99, lower: 0)
    @verse_template = verse_template
    @upper = upper
    @lower = lower
  end

  def song
    verses(upper, lower)
  end

  def verses(upper, lower)
    upper.downto(lower).map { |i| verse(i) }.join("\n")
  end

  def verse(number)
    verse_template.lyrics(number)
  end
end

class BottleVerse
  attr_reader :bottle_number

  def initialize(bottle_number)
    @bottle_number = bottle_number
  end

  def self.lyrics(number)
    new(number.to_bottle_number).lyrics
  end

  def lyrics
    # bottle_number = BottleNumber(self.bottle_number)

    "#{bottle_number} of beer on the wall, ".capitalize +
    "#{bottle_number} of beer.\n" +
    "#{bottle_number.action}, " +
    "#{bottle_number.successor} of beer on the wall.\n"
  end
end

class BottleNumber
  def self.for(number)
    case number
    when 0
      BottleNumber0
    when 1
      BottleNumber1
    else
      BottleNumber
    end.new(number)
  end

  attr_reader :number

  def initialize(number)
    @number = number
  end

  def to_s
    "#{quantity} #{container}"
  end

  def quantity
    number.to_s
  end

  def container
    "bottles"
  end

  def action
    "Take #{pronoun} down and pass it around"
  end

  def pronoun
    "one"
  end

  def successor
    BottleNumber(number - 1)
  end
end

class BottleNumber0 < BottleNumber
  def quantity
    "no more"
  end

  def action
    "Go to the store and buy some more"
  end

  def successor
    99.to_bottle_number
  end
end

class BottleNumber1 < BottleNumber
  def container
    "bottle"
  end

  def pronoun
    "it"
  end
end
