require_relative 'offset'
require_relative 'key'
require_relative 'cipher'
require_relative 'reader'

module Enigma
  class Decrypt
    # def convert(arr)
    #   key = ""
    #   arr.each_with_index do |c,i|
    #     if i==0
    #       if (78+c.to_i>100)
    #         key+= (c.to_i+39).to_s
    #       else
    #         key+=(78+c.to_i).to_s
    #       end
    #     else
    #       if (78+c.to_i>100)
    #         # return key if i==2
    #         key+= (c.to_i+39).to_s[1]
    #       else
    #         key+=(78+c.to_i).to_s[1]
    #       end
    #     end
    #   end
    #   key[0..4]
    #   # arr
    # end
    def convert(sentence,arr)
      nnn = []
      nnn.push(arr[0].to_s)
      arr = arr[1..-2]
      arr.each_with_index do |c, i|
        if c.to_s[0] != nnn[-1][1]
          nnn << (c.to_i + 39).to_s
        else
          nnn << c.to_s
        end
      end
      nnn.push(arr[-1].to_s)
      test = nnn[0]+nnn[1][1]+nnn[3]
      nnn
    end

    def con(sentence,arr)
      nnn = []
      arr.each do |c|
        if c.to_i < 10
          nnn << c.to_i + 39
        else
          nnn << c.to_i
        end
      end
      convert(sentence,nnn)
    end

    def decode_key(sentence, offset)
      last_chars = sentence[-7..-1]
      size = sentence.size % 4
      last_message = "..end..".split("")
      key = []
      offset = offset.rotate(size+1)
      last_chars.zip(offset.cycle,last_message) do |c, o, l|
        c = (/\A[-+]?\d+\z/ === c) ? c.to_i : c
        39.times do |i|
          if Cipher.encrypt_letter(c, -(i.to_i+o.to_i)) == l
            key.push(i.to_s)
          end
        end
      end
      start = 7-(4+size)
      p con(sentence[-7..-1],key[start..start+4])
    end


    def decrypt(output_file,input_file, key=0, offset)
      text = Reader.read(output_file).split("")
      offset = key if ARGV.size == 2
      offset = Offset.get(offset)
      keyy = Key.new
      formatted_key = keyy.formatter(key)
      p formatted_key
      return decode_key(text, offset) if ARGV.size == 2
      decrypted_text = text.zip(formatted_key.cycle, offset.cycle).collect do |a,b,c|
        char = (/\A[-+]?\d+\z/ === a) ? a.to_i : a
        Cipher.encrypt_letter(char,-(b.to_i+c.to_i))
      end
      # p decrypted_text.join
      Reader.output(input_file, decrypted_text.join)
      p "Decrypted"
    end
  end
end
e = Enigma::Decrypt.new

e.decrypt(ARGV[0],ARGV[1],ARGV[2], ARGV[3])
