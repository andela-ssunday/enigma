require_relative '../lib/Enigma/encrypt'

module Enigma
  describe "Encrypt" do
    e = Encrypt.new
    it " can encrypt a word" do
      expect(e.encrypt("message.txt","output.txt", "26278", "260815")).to eql("4wcjje3l8")
    end

  end
end
