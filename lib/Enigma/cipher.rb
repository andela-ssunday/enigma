module Enigma
  class Cipher
    private
      def self.allowed_chars
        allowed = []
        allowed += ('a'..'z').to_a
        allowed += (0..9).to_a
        allowed << ' '
        allowed << '.'
        allowed << ','
        allowed
      end

      def self.cipher(rotation)
        rotated_chars = self.allowed_chars.rotate(rotation)
        Hash[allowed_chars.zip(rotated_chars)]
      end

    public
      def self.encrypt_letter(letter, rotation)
        chars = self.cipher(rotation)
        chars[letter]
      end
  end
end
