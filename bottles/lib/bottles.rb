class Bottles
  def song
    verses(99, 0)
  end

  def verses(upper, lower)
    upper.downto(lower).map { |i| verse(i) }.join("\n")
  end

  # #{quantity(number).to_s.capitalize} contains a hidden conditional: if a string already passes it, otherwise convert.
  def verse(number)
    case number
    when 0
      <<~VERSE
        #{quantity(number).capitalize} #{container(number)} of beer on the wall, #{quantity(number)} #{container(number)} of beer.
        #{action(number)}, #{quantity(99)} #{container(99)} of beer on the wall.
      VERSE
    else
      <<~VERSE
        #{quantity(number).capitalize} #{container(number)} of beer on the wall, #{quantity(number)} #{container(number)} of beer.
        #{action(number)}, #{quantity(number-1)} #{container(number-1)} of beer on the wall.
      VERSE
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

  # Liskov substitution: 'if you make a promise, keep it'. Super strict-specific meaning:
  # If S is a subtype of T, then objects of type T may be replaced with objects of type S.

  def quantity(number)
    # if number == -1 # don't like this
    #   '99'
    if number == 0
      'no more'
    else
      number.to_s
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
