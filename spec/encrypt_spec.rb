require_relative '../lib/Enigma/encrypt'
require "pry"

module Enigma
  describe "Encrypt" do
    let(:e){Encrypt.new}
    let(:file){"message.txt"}

    before(:each) do
      f = File.open(file, 'w')
      f.write("hello..end..")
      f.close
    end

    it " can encrypt a word" do
      encrypted = e.encrypt("message.txt","output.txt")
      expect(encrypted.size).to eql(12)
    end

    it " Encrypted word should not be the same as text" do
      encrypted = e.encrypt("message.txt","output.txt")
      expect(encrypted).not_to eql("..end..")
    end
  end
end
