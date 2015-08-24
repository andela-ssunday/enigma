class Enigma_D
  def allowed_chars
    allowed = []
    allowed += ('a'..'z').to_a
    allowed += (0..9).to_a
    allowed << ' '
    allowed << '.'
    allowed << ','
    allowed
  end

  def cipher(rotation)
    rotated_chars = allowed_chars.rotate(rotation)
    Hash[allowed_chars.zip(rotated_chars)]
  end

  def encrypt_letter(letter, rotation)
    chars = cipher(rotation)
    chars[letter]
  end

  def format_key(key)
    # raise exception if key is less than 5
    new_key = []
    4.times do |i|
      new_key.push(key[i..i+1])
    end
    new_key
  end

  def format_offset(offset)
    striped_offset = offset[0]==0 ? offset[1..-1] : offset
    new_offset = (striped_offset.to_i ** 2).to_s
    new_offset[-4..-1].split("")
  end

  def decode_key(sentence, offset)
    last_chars = sentence[-7..-1]
    size = sentence.size % 4
    last_message = "..end..".split("")
    key = []
    # offset = offset.rotate(size+1)
    last_chars.zip(offset.cycle,last_message) do |c, o, l|
      c = (/\A[-+]?\d+\z/ === c) ? c.to_i : c
      puts encrypt_letter(7, -(29)); return;
      allowed_chars.size.times do |i|
        if encrypt_letter(c, -(i+o.to_i)) == l
          key.push((o.to_i + i))
          # p key; return;
        end
      end
    end
    p key
  end

  def decrypt(sentence, key=0, offset)
    sentence = sentence.split("")
    offset = key if ARGV.size == 2
    offset = format_offset(offset)
    return decode_key(sentence, offset) if ARGV.size == 2
    key = format_key(key)
    descrypto = sentence.zip(key.cycle, offset.cycle).collect do |a,b,c|
      char = (/\A[-+]?\d+\z/ === a) ? a.to_i : a
      encrypt_letter(char,-(b.to_i+c.to_i))
    end
    p descrypto.join
  end
  # def encrypt(sentence, key=0, offset)
  #   key = decode_key(sentence, offset) if key==0
  #   p encrypter(sentence, key, offset)
  # end
end

e = Enigma_D.new

e.decrypt(ARGV[0],ARGV[1],ARGV[2])
