#require 'rubygems'
#require 'Rmagick'
#require 'rmagick'
#require 'Rmagic'
class NoisyImage
require 'RMagick'
include Magick

  attr_reader :code, :code_image
  Jiggle = 15
  Wobble = 15
  def initialize(len)
    chars = ('a'..'z').to_a - ['a','e','i','o','u']
    code_array=[]
    1.upto(len) {code_array << chars[rand(chars.length)]}
    granite = Magick::ImageList.new('xc:#EDF7E7')
    canvas = Magick::ImageList.new
    canvas.new_image(32*len, 50, Magick::TextureFill.new(granite))
    text = Magick::Draw.new
    text.font_family = "times"
    text.pointsize = 40
    cur = 10
    code_array.each{|c|
      rand(10) > 5 ? rot=rand(Wobble):rot= -rand(Wobble)
      rand(10) > 5 ? weight = NormalWeight : weight = BoldWeight
      text.annotate(canvas,0,0,cur,30+rand(Jiggle),c){
        self.rotation=rot
        self.font_weight = weight
        self.fill = "green"
      }
      cur += 30
    }
    @code = code_array.to_s
    @code_image = canvas.to_blob{
      self.format= "JPG"
    }
  end
end
