module Enigma
  class Cipher
    attr_reader :char_map

    private
      def self.char_map
        allowed = []
        allowed += ('a'..'z').to_a
        allowed += (0..9).to_a
        allowed << ' '
        allowed << '.'
        allowed << ','
        allowed
      end

      def self.cipher(rotation)
        rotated_chars = self.char_map.rotate(rotation)
        Hash[char_map.zip(rotated_chars)]
      end

    public
      def self.encrypt_letter(letter, rotation)
        chars = self.cipher(rotation)
        chars[letter]
      end
  end
end
