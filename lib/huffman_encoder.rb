require_relative 'node'
require_relative 'leaf'

class HuffmanEncoder 
  
  # ハフマン符合化を行う文字列
  attr_reader :message 

  # 各々の文字の出現頻度
  attr_reader :frequencies

  # ハフマン木の根
  attr_reader :root

  # 各々の文字に割り当てるビット列
  attr_reader :binary_values

  # 文字列の符合化によって得られたビット列
  attr_reader :encoded_string

  def initialize(message, debug=false)
    @message = message 
    @debug = debug

    @frequencies = self.collect_frequencies(@message)
    @root = self.make_tree(@frequencies)
    @binary_values = self.collect_binary_values(@root)
    @encoded_string = self.generate_encoded_string(@message, @binary_values)
  end

  private

  attr_reader :debug

  # 文字の出現確率を計算
  def collect_frequencies(string)
    frequencies = Hash.new(0)
    string.each_char do |char|
      frequencies[char] += 1 
    end
    frequencies
  end

  # ハフマン木を生成
  def make_tree(frequencies)
    nodes = []
    frequencies.each do |char, value|
      nodes << Leaf.new(char: char, value: value)
    end
    nodes.sort!
    p nodes if self.debug

    while nodes.size > 1
      left  = nodes.shift 
      right = nodes.shift
      total_value = left.value + right.value 

      nodes.unshift Node.new(value: total_value, left: left, right: right)
      nodes.sort!

      p nodes if self.debug
    end

    nodes.first 
  end

  # 文字に割り当てるビット列を求める
  def collect_binary_values(root)
    binary_values = Hash.new 
    dfs(root, binary_values)
    binary_values
  end

  # ハフマン木の深さ優先探索
  def dfs(node, binary_values, binary_string = "")
    if node.is_a?(Leaf)
      binary_values[node.char] = binary_string
      return 
    end
    dfs(node.left,  binary_values, binary_string.dup << "0")
    dfs(node.right, binary_values, binary_string.dup << "1")
  end

  # 符合化された文字列を生成
  def generate_encoded_string(message, binary_values)
    encoded_string = ""
    message.each_char do |char|
      encoded_string << self.binary_values[char]
    end
    encoded_string
  end

end

if __FILE__ == "lib/huffman_encoder.rb"
  encoder = HuffmanEncoder.new("aaaaabbbcd", debug=true)
  p encoder.binary_values
  p encoder.encoded_string
end

