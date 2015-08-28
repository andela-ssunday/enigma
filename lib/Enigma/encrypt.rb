require_relative 'offset'
require_relative 'key'
require_relative 'cipher'
require_relative 'reader'

module Enigma
  class Encrypt

    def encrypt(output_file,input_file)
      text = Reader.read(output_file).split("")
      offset = Offset.get
      key = Key.new
      formatted_key = key.formatter
      encrypted_text = text.zip(formatted_key.cycle, offset.cycle).collect do |a,b,c|
        char = (/\A[-+]?\d+\z/ === a) ? a.to_i : a
        Cipher.encrypt_letter(char,(b.to_i+c.to_i))
      end
      Reader.output(input_file, encrypted_text.join)
      p "Encrypted with #{key.get} and #{Offset.date_today}"
      encrypted_text.join
    end

  end
end
e = Enigma::Encrypt.new

input = ARGV[0] || input;
output = ARGV[1] || output;


e.encrypt(input, output) if !output.nil?
