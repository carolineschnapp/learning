class House
  DATA =
    [ "the horse and the hound and the horn that belonged to",
      "the farmer sowing his corn that kept",
      "the rooster that crowed in the morn that woke",
      "the priest all shaven and shorn that married",
      "the man all tattered and torn that kissed",
      "the maiden all forlorn that milked",
      "the cow with the crumpled horn that tossed",
      "the dog that worried",
      "the cat that killed",
      "the rat that ate",
      "the malt that lay in",
      "the house that Jack built"]
  attr_reader :data, :prefix

  def initialize(orderer: UnchangedOrderer.new, prefixer: ThisIsPrefixer.new, data_preparer: NoDataPrep.new)
    @data = orderer.order(data_preparer.arrange(DATA))
    @prefix = prefixer.text
  end

  def recite
    1.upto(12).collect {|i| line(i)}.join("\n")
  end

  def phrase(num=1)
    data.last(num).join(" ")
  end

  def line(num)
    "#{prefix} #{phrase(num)}.\n"
  end
end

class RandomOrderer
  def order(data)
    data.shuffle
  end
end

class UnchangedOrderer
  def order(data)
    data
  end
end

class RandomExceptLastOrderer
  def order(data)
    data[0..-2].shuffle.push(data.last)
  end
end

class RandomHouse < House
  def initialize
    super(orderer: RandomOrderer.new)
  end
end

class PirateHouse < House
  def initialize
    super(prefixer: PiratePrefixer.new)
  end
end

class ThisIsPrefixer
  def text
    "This is"
  end
end

class PiratePrefixer
  def text
    "Argggggggg"
  end
end

class PirateRandomHouse < House
  def initialize
    super(orderer: RandomOrderer.new, prefixer: PiratePrefixer.new)
  end
end

class RandomExceptLastHouse < House
  def initialize
    super(orderer: RandomExceptLastOrderer.new)
  end
end

class NoDataPrep
  def arrange(data)
    data
  end
end

class ShuffleActorsAndActions
  def arrange(data)
    actors = []
    actions = []
    lines = []
    data.each do |line|
      actors << line.split('that').first
      actions << 'that' + line.split('that').last
    end
    actors.shuffle.each_with_index do |actor, index|
      lines << actor + actions[index]
    end
    lines
  end
end

class BrendaHouse < House
  def initialize
    super(data_preparer: ShuffleActorsAndActions.new)
  end
end

# class PirateRandomHouse < House
#   attr_reader :object
#
#   def initialize
#     @object = PirateHouse.new(orderer: RandomOrderer.new)
#   end
#
#   def line(num)
#     object.line(num)
#   end
# end

puts House.new.line(12)
puts PirateHouse.new.line(12)
puts RandomHouse.new.line(12)
puts RandomHouse.new.line(12)
puts PirateRandomHouse.new.line(12)
puts PirateRandomHouse.new.line(12)
puts RandomExceptLastHouse.new.line(12)
puts BrendaHouse.new.line(12)
