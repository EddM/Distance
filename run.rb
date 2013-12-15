require 'gosu'
require 'require_all'

require_all File.dirname(__FILE__) + "/lib/"

window = GameWindow.new(1024, 768)
window.show
