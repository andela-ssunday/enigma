require_relative '../lib/Enigma/encrypt'
require_relative '../lib/Enigma/decrypt'

module Enigma
  describe "Decrypt" do
    let(:e){Encrypt.new}
    let(:d){Decrypt.new}
    let(:file){"message.txt"}

    it " can decrypt a word" do
      f = File.open(file, 'w')
      f.write("hello..end..")
      encrypted = e.encrypt("message.txt","output.txt")
      f.close
      decrypted = d.decrypt("output.txt","message.txt", "2345", "20615")
      expect(decrypted).to eql("Decrypted ")
    end

    it " Decrypted word should be same as text" do
      skip
      # expect(decrypted).to eql("..end..")
    end
  end
end
