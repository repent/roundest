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
    f.clean!
  end
end