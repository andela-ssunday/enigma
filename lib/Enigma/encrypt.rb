require_relative 'offset'
require_relative 'key'
require_relative 'cipher'
require_relative 'reader'

# binding.pry;
module Enigma
  class Encrypt


    def encrypt(output_file,input_file, key=0, offset)
      # text = output_file.split("")
      text = Reader.read(output_file).split("")
      offset = Offset.get
      key = Key.new
      formatted_key = key.formatter
      p formatted_key
      encrypted_text = text.zip(formatted_key.cycle, offset.cycle).collect do |a,b,c|
        char = (/\A[-+]?\d+\z/ === a) ? a.to_i : a
        Cipher.encrypt_letter(char,(b.to_i+c.to_i))
      end
      Reader.output(input_file, encrypted_text.join)
      p "Encrypted with #{key.get} and #{Offset.date_today}"
    end

  end
end
e = Enigma::Encrypt.new

e.encrypt(ARGV[0],ARGV[1],ARGV[2], ARGV[3])
# e.encrypt(ARGV[0],ARGV[1],ARGV[2])
