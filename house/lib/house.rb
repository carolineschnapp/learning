require 'pry'

class House
  DATA = [
    'the horse and the hound and the horn that belonged to',
    'the farmer sowing his corn that kept',
    'the rooster that crowed in the morn that woke',
    'the priest all shaven and shorn that married',
    'the man all tattered and torn that kissed',
    'the maiden all forlorn that milked',
    'the cow with the crumpled horn that tossed',
    'the dog that worried',
    'the cat that killed',
    'the rat that ate',
    'the malt that lay in',
    'the house that Jack built',
  ]

  def recite
    1.upto(12).map do |index|
      line(index)
    end
      .join("\n")
  end

  def phrase(num=1)
    data.last(num).join(' ')
  end

  def line(num)
    "#{prefix} #{phrase(num)}.\n"
  end

  def prefix
    'This is'
  end

  def data
    DATA
  end
end

class RandomHouse < House
  def data
    @data ||= super.shuffle
  end
end

puts RandomHouse.new.recite

class RandomExceptLast < House
  # Called with no arguments and no empty argument list,
  # super calls the appropriate method with the same arguments, and the same code block,
  # as those used to call the current method.
  # Called with an argument list or arguments, it calls the appropriate methods
  # with exactly the specified arguments (including none, in the case of an empty argument list
  # indicated by empty parentheses).
  def data
    @data ||= super[0..-2].shuffle.push(super.last)
  end
end

puts RandomExceptLast.new.recite
