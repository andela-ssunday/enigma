require_relative '../lib/Enigma/offset'

module Enigma
  describe "Key" do
    it "" do
      key = Key.new
      expect(key.get.size).to be(5)
    end
  end
end
