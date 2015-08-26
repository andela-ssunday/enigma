require 'date'
module Enigma
  class Offset
    class << self; attr_accessor :date_today end
    @date_today = Date.today.strftime("%d%m%y")
    def self.get(offset=0)
      offset = (offset==0) ? @date_today : offset
      striped_offset = offset[0]==0 ? offset[1..-1] : offset
      new_offset = (striped_offset.to_i ** 2).to_s
      new_offset[-4..-1].split("")
    end
  end
end
