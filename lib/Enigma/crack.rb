require_relative 'offset'
require_relative 'key'
require_relative 'cipher'
require_relative 'reader'
require_relative 'decrypt'

module Enigma
  class Crack
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


    def konvert(key,iteration=0)
      key = add_zeros(key) if iteration!=1
      new_key = []
      new_key.push(key.shift)

      key.each do |k|
        if checker(new_key[-1][1],k[0])
          new_key << k
        elsif checker(new_key[-1][1],(k.to_i+39).to_s[0])
          new_key << (k.to_i+39).to_s
        elsif checker(new_key[-1][1],(k.to_i+(39*2)).to_s[0])
          new_key << (k.to_i+(39*2)).to_s
        elsif key.index(k) < 3 && !k.nil?
          v = key.unshift((new_key[0].to_i+39).to_s)[0..-2]
          return konvert(v, 1)
        end
      end
      return "Error occured while decypting" if new_key.size<4
      new_key[0]+new_key[1][1]+new_key[2][1]+new_key[3][1]

    end

    def decode_key(input, output, offset)
      # p input;return
      old_offset = offset
      offset = Offset.get(offset)
      text = Reader.read(input).split("")
      last_chars = text[-7..-1]
      size = text.size % 4
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
      key = key[start..start+4]
      new_key = konvert(key)
      if new_key.size!=5
        p new_key
        return;
      end
      e = Decrypt.new
      e.decrypt(input, output, new_key, old_offset)
    end
  end
end
e = Enigma::Crack.new

e.decode_key(ARGV[0],ARGV[1],ARGV[2])
