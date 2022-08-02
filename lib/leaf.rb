require_relative 'node'

# ハフマン木の葉
class Leaf < Node
  # 文字
  attr_reader :char

  def initialize(char:, value:)
    @char = char 
    @value = value 
    @left = nil
    @right = nil
  end

  def inspect 
    "(#{char}, #{value})"
  end
end