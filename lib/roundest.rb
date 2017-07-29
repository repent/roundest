require 'pry'

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

#def rounder(n)
#  m = 10 * n
#end

class Floteger
  include Comparable

  def initialize(value=0, exp=1)
    @value=value.to_i
    @exponent=exp.to_i
  end
  def to_f
    @value.to_f * 10 ** @exponent
  end
  def to_s
    s = @value.to_s
    case
    when @exponent == 0
    when @exponent > 0
      s += '0' * @exponent
    when (@exponent < 0 and s.length > inv_exp)
      split = s.length + @exponent
      s = s[0..(split-1)] + '.' + s[split..-1]
    #when @exponent < 0 and s.length > (0 - @exponent)
    else
      # pad front with zeros
      s = '0.' + '0' * (inv_exp - s.length)  + s
    end
    s      
  end
  def round_down
    raise "Cannot round #{self.to_s}" unless sf > 1
    v = @value.to_s[0...-1]
    e = @exponent + 1
    Floteger.new(v, e)
  end
  def round(direction=:up, dp=1)
    dir = case direction
    when :up
      1
    when :down
      0
    else
      raise "Invalid direction #{direction.to_s}"
    end
    raise "Cannot round #{self.to_s}" unless sf > 1
    v = @value.to_s[0...(-dp)].to_i + dir
    e = @exponent + dp
    Floteger.new(v, e)
  end
  def end_in_five
    v = @value.to_s
    v[-1] = '5'
    Floteger.new(v,@exponent)
  end
  def ends_in_five?
    @value.to_s[-1] == '5'
  end
  #def round!(dp=1); self = round(dp); end
  def clean
    return self if @value.to_s[-1] != '0'
    round
  end
  #def clean!; self = self.clean; end
  def **(e)
    @exponent += e
    self
  end
  def <=>(f); self.to_f <=> f; end

  private

  def sf
    @value.to_s.length
  end
  def inv_exp
    -@exponent
  end
end

class Float
  def to_floteger
    s = self.to_s
    #f = Floteger.new
    if s =~ /e/
      v,e = s.split('e')
      e = e.to_i
      f = simple_floteger(v)
      f ** e
      #a,b = v.split('.')
      #e = e - b.length
      #v = a + b
      #return Floteger.new(v,e)
    else
      simple_floteger(s)
    end
  end

  private
  def simple_floteger(v)
    a,b = v.split('.')
    e = -b.length
    v = a + b
    f = Floteger.new(v,e)
    while f != f.clean
      f = f.clean
    end
    f
  end
end

#f = Floteger.new(42736, -4)
#g = Floteger.new(42736, 3)
#h = Floteger.new(42736, -7)
#i = Floteger.new(42736, 0)
#puts f.to_s
#puts i.to_s
#puts g.to_s
#puts h.to_s
##split = 5 + -4 = 1
##s = s[0..1]
#
binding.pry