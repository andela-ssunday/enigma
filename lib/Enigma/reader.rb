module Enigma
  class Reader
    def self.read(file)
      f = File.open("#{file}", 'r')
      text = f.read
      f.close
      return text
    end

    def self.output(file,text)
      f = File.open(file, 'w')
      f.write(text)
      f.close
    end
  end
end
