require "Enigma/version"

module Enigma
  # Your code goes here...
end

APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))
Dir[APP_ROOT.join('lib', 'Enigma', '*.rb')].each { |f| require f unless f.include? 'extension'}
