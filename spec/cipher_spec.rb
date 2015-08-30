require_relative '../lib/Enigma/cipher'
module Enigma
  describe "Cipher" do
    it "should have a character map of size 39 " do
      expect(Cipher.char_map.size).to eql(39)
    end

    it "Can rotate the character map based on the number of rotations supplied" do
      char = Cipher.encrypt_letter('a',8)
      expect(char).to eql('i')
    end
  end
end
