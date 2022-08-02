# ハフマン木のノード
class Node 
  include Comparable

  # ノードの値
  attr_reader :value

  # 一つ目の子ノード
  attr_reader :left 

  # 二つ目の子ノード
  attr_reader :right 

  def initialize(value:, left: nil, right: nil)
    @value = value 
    @left = left 
    @right = right
  end

  def <=>(other)
    self.value <=> other.value
  end

  def inspect 
    str = "#{value}"

    unless left.nil?
      str << ", #{left.inspect}"
    end

    unless right.nil?
      str << ", #{right.inspect}"
    end

    "(" + str + ")"
  end

end