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
      # nnn
    end

    def add_zeros(arr)
      arr.map do |a|
          if a.to_i < 10
              '0'+a.to_s
          else
              a.to_s
          end
      end
    end

    def checker(v1,v2)
      return v1==v2
    end


    def konvert(key)
      key = add_zeros(key)
      new_key = []
      new_key.push(key.pop)
      key.each do |k|
        if checker(new_key[-1][1],k[0])
          new_key << k
        elsif checker(new_key[-1][1],(k.to_i+39).to_s[0])
          new_key << (k.to_i+39).to_s
        elsif checker(new_key[-1][1],(k.to_i+(39*2)).to_s[0])
          new_key << (k.to_i+(39*2)).to_s
        end
      end
      (new_key[0]==new_key[1]) ? new_key.shift : new_key
      new_key[0]+new_key[1][1]+new_key[2][1]+new_key[3][1]
    end

    def decode_key(sentence, offset)
      last_chars = sentence[-7..-1]
      size = sentence.size % 4
      last_message = "..end..".split("")
      key = []
      offset = offset.rotate(size+1)
      last_chars.chars.zip(offset.cycle,last_message) do |c, o, l|
        c = (/\A[-+]?\d+\z/ === c) ? c.to_i : c
        39.times do |i|
          if Cipher.encrypt_letter(c, -(i.to_i+o.to_i)) == l
            key.push(i.to_s)
          end
        end
      end
      start = 7-(4+size)
      key = key[start..start+4]
      # key = key[0]+(key[1].size==1 ? key[1] : key[1][1])+(key[2].size==1 ? key[2] : key[2][1])+(key[3].size==1 ? key[3] : key[3][1])
      p konvert(key)
    end


    def decrypt(output_file,input_file, key=0, offset)
      offset = input_file if ARGV.size == 2
      offset = Offset.get(offset)
      return decode_key(output_file, offset) if ARGV.size == 2
      text = Reader.read(output_file).split("")
      keyy = Key.new
      formatted_key = keyy.formatter(key)
      # p formatted_key
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
