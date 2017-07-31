class Floteger
  include Comparable

  class RecoverableError < StandardError
  end

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
    raise RecoverableError, "Cannot round #{self.to_s}" unless sf > 1
    v = @value.to_s[0...(-dp)].to_i + dir
    e = @exponent + dp
    Floteger.new(v, e)
  end
  def round_if_possible(direction=:up, dp=1)
    begin
      round(direction, dp)
    rescue RecoverableError
      return self
    end
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
  # NOT WORKING rounds 42370e-1 to 4238
  def clean! # deals with @value ending in 0
    while @value.to_s[-1] == '0'
      @value = @value.to_s[0...-1].to_i
      @exponent += 1
    end
    self
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
