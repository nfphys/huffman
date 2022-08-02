require 'minitest/autorun'

require_relative '../lib/huffman_encoder'

class HuffmanEncoderTest < Minitest::Test 
  def test_compaire_nodes
    assert Node.new(value: 10) < Node.new(value: 20)
  end

  def test_compaire_leaves
    assert Leaf.new(char: 'A', value: 10) < Leaf.new(char: 'D', value: 20)
    assert Leaf.new(char: 'B', value: 20) > Node.new(value: 10)
  end

  def test_leaf_inspect 
    assert_equal "(A, 10)", Leaf.new(char: 'A', value: 10).inspect
  end

  def test_node_inspect 
    a10  = Leaf.new(char: 'A', value: 10)
    b20 = Leaf.new(char: 'B', value: 20)
    assert_equal "(30, (A, 10), (B, 20))", Node.new(value: 30, left: a10, right: b20).inspect
  end

  def test_huffman_encoder
    assert HuffmanEncoder
    assert HuffmanEncoder.new('abddbabddd')
  end

  def test_collect_frequencies 
    expected = {'a'=>2, 'b'=>3, 'd'=>5}
    assert_equal expected, HuffmanEncoder.new('aabbbddddd').frequencies

    expected = {'x'=>1, 'y'=>4, 'z'=>2}
    assert_equal expected, HuffmanEncoder.new('xyyyyzz').frequencies
  end

  def test_make_tree 
    assert_equal "(10, (5, (a, 2), (b, 3)), (d, 5))", HuffmanEncoder.new('aabbbddddd').root.to_s 
    assert_equal "(7, (3, (x, 1), (z, 2)), (y, 4))", HuffmanEncoder.new('xyyyyzz').root.to_s
  end

  def test_collect_binary_values 
    expected = {'a'=>'00', 'b'=>'01', 'd'=>'1'}
    assert_equal expected, HuffmanEncoder.new('aabbbddddd').binary_values

    expected = {'x'=>'00', 'y'=>'1', 'z'=>'01'}
    assert_equal expected, HuffmanEncoder.new('xyyyyzz').binary_values
  end

  def test_generate_encoded_string 
    assert_equal '000001010111111', HuffmanEncoder.new('aabbbddddd').encoded_string
    assert_equal '0011110101', HuffmanEncoder.new('xyyyyzz').encoded_string 
  end

end