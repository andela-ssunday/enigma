require_relative '../lib/Enigma/offset'
require 'date'

module Enigma
  describe "offset" do

    it " offset should be 4 digits" do
      offset = Offset.get
      expect(offset.size).to be(4)
    end


    it " should conform to todays date" do
      offset = Offset.get

      date_today = Date.today.strftime("%d%m%y")
      striped_offset = (date_today[0]!=0) ? date_today : date_today[1..-1]
      offset_from_today = ((striped_offset.to_i ** 2).to_s[-4..-1]).split("")
      expect(offset).to eq(offset_from_today)
    end
  end
end
