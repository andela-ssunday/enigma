require_relative '../lib/Enigma/key'

module Enigma
  describe "Key" do
    it "Key to be generated and have a length of 5" do
      key = Key.new
      expect(key.get).not_to be_empty
      expect(key.get.size).to be(5)
    end
  end
end
