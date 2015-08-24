class Enigma
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



  def encrypt(sentence, key=0, offset)
    sentence = sentence.split("")
    offset = format_offset(offset)
    key = format_key(key)
    encrypto = sentence.zip(key.cycle, offset.cycle).collect do |a,b,c|
      char = (/\A[-+]?\d+\z/ === a) ? a.to_i : a
      encrypt_letter(char,(b.to_i+c.to_i))
    end
     p encrypto.join
  end

end

e = Enigma.new

e.encrypt(ARGV[0],ARGV[1],ARGV[2])
