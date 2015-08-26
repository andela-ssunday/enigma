module Enigma
  class Key

    @@key = rand(20000..30000).to_s #generate key by random here

    def get
      return @@key
    end

    def formatter(key=0)
      key = (key==0) ? @@key : key
      new_key = []
      4.times do |i|
        new_key.push(key.to_s[i..i+1])
      end
      new_key
    end
  end
end
