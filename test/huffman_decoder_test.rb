require 'minitest/autorun'

require_relative '../lib/huffman_encoder'
require_relative '../lib/huffman_decoder'

class HuffmanDecoderTest < Minitest::Test 
  def test_decode 
    encoder = HuffmanEncoder.new("aaaaabbbcd")
    binary_values = encoder.binary_values 
    encoded_string = encoder.encoded_string 
    assert_equal "aaaaabbbcd", HuffmanDecoder.decode(binary_values, encoded_string)

    encoder = HuffmanEncoder.new("xyyyyzz")
    binary_values = encoder.binary_values 
    encoded_string = encoder.encoded_string 
    assert_equal "xyyyyzz", HuffmanDecoder.decode(binary_values, encoded_string)
  end
end