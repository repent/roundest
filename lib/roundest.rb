require 'floteger'
require 'float'

class Roundest

  VERSION = '0.1'

  #def between(min, max)
  #  min,max = max,min unless max >= min
  #  start = (min.to_f + max.to_f) / 2
  #  raise "Weird fuckup" unless start < max and start > min
  #
  #end
  #
  #def iterate(min,max)
  #  min,max = max,min unless max >= min
  #  start = ((min.to_f + max.to_f) / 2).to_floteger
  #  x = start
  #  dump(x,min,max)
  #  (1..20).each do |i|
  #    y = x.round
  #    break unless y < max and y > min
  #    x = y
  #    dump(x,min,max)
  #  end
  #end
  
  def dump(current,min,max)
    puts "Current guess: #{current} [between #{min} and #{max}]"
  end
  
  def break_point(low,high)
    low,high = high,low if low > high
    return low if low == high
    # arbitrary starting point
    guess = ((low.to_f + high.to_f) / 2).to_floteger
    # round down
    while better_guess(guess,low,high)
      guess = better_guess(guess,low,high)
      dump guess, low, high
    end
    guess
  end
  
  def better_guess(guess,low,high)
    # try rounding down
    better = guess.round(:down)
    if better > low and better < high
      return better
    else
      # try rounding up
      better = guess.round(:up)
      if better > low and better < high
        retun better
      else
        # try ending in 5
        return false if guess.ends_in_five?
        better = guess.end_in_five
        if better > low and better < high
          return better
        end
      end
      return false
    end
  end
end
