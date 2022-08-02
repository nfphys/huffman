require_relative 'huffman_encoder'

class HuffmanDecoder 
  def self.decode(binary_values, encoded_string)
    decoded_string = ""
    
    i = 0
    while i < encoded_string.size - 1
      binary_values.each do |char, value| 
        j = i + value.to_s.size
        next if j > encoded_string.size 

        if encoded_string[i...j] == value
          decoded_string << char 
          i = j
          break
        end
        
      end
      
    end

    decoded_string
  end
end

if __FILE__ == "lib/huffman_decoder.rb"
  encoder = HuffmanEncoder.new("aaaaabbbcd", debug=true)
  p HuffmanDecoder.decode(encoder.binary_values, encoder.encoded_string)
end