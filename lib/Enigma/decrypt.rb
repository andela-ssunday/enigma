require_relative 'offset'
require_relative 'key'
require_relative 'cipher'
require_relative 'reader'

module Enigma
  class Decrypt

    def decrypt(output_file,input_file, key=0, offset)
      offset = Offset.get(offset)
      return decode_key(output_file, offset) if ARGV.size == 2
      text = Reader.read(output_file).split("")
      keyy = Key.new
      formatted_key = keyy.formatter(key)
      decrypted_text = text.zip(formatted_key.cycle, offset.cycle).collect do |a,b,c|
        char = (/\A[-+]?\d+\z/ === a) ? a.to_i : a
        Cipher.encrypt_letter(char,-(b.to_i+c.to_i))
      end
      Reader.output(input_file, decrypted_text.join)
      p "Decrypted "
    end
  end
end
e = Enigma::Decrypt.new

input = ARGV[0] || input;
output = ARGV[1] || output;
key = ARGV[2] || key;
offset = ARGV[3] || offset;

e.decrypt(input, output, key, offset) if !offset.nil?
