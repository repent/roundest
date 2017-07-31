require 'floteger'
require 'float'
require 'roundest/version'

require 'pry'

class Roundest

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

  # Class methods

  def self.roundest(low,high,verbose=false)
    break_point(low,high,verbose)
  end

  private
  
  def self.dump(current,min,max)
    puts "Current guess: #{current} [between #{min} and #{max}]"
  end
  
  def self.break_point(low,high,verbose=false)
    low,high = high,low if low > high
    return low if low == high
    # arbitrary starting point
    puts "Range: #{low} to #{high}" if verbose
    guess = ((low.to_f + high.to_f) / 2).to_floteger
    puts "Starting point: #{guess}" if verbose
    # round down
    while better_guess(guess,low,high)
      guess = better_guess(guess,low,high)
      puts "Found rounder number: #{guess}" if verbose
      #dump guess, low, high
    end
    puts "Roundest number is: #{guess}" if verbose
    guess
  end
  
  def self.better_guess(guess,low,high)
    # try rounding down
    better = guess.round_if_possible(:down)
    #binding.pry
    if better != guess and better > low and better < high
      return better
    else
      # try rounding up
      better = guess.round_if_possible(:up)
      if better != guess and better > low and better < high
        return better
      else
        # try ending in 5
        return false if guess.ends_in_five?
        better = guess.end_in_five
        if better != guess and better > low and better < high
          return better
        end
      end
      return false
    end
  end
end

