require "doge/version"
require 'RMagick'


class Doge
  attr_reader :image

  def initialize(&block)
    @image = Magick::ImageList.new(File.expand_path('doge/images/doge.jpg', File.dirname(__FILE__)))
    @occupied = []
    instance_eval &block if block
  end

  def wuff(term)
    text = image_text
    metrics = text.get_type_metrics(@image, term)
    horizontal_padding = @image.columns * 0.1
    horizontal_top = @image.columns - horizontal_padding - metrics.width
    height = metrics.height.round + 5 #padding
    @image.annotate(text, 0,0, Random.rand(horizontal_padding..horizontal_top), y_for_height(height), term)
    self
  end

  [:such, :wow, :so, :much, :amaze, :very].each do |word|
    define_method(word) { |text = ''| wuff(word.to_s  + " " + text) }
  end

private
  def random_rgb
    "rgb(#{Random.rand(0..255)}, #{Random.rand(0..255)}, #{Random.rand(0..255)})"
  end

  def image_text
    text = Magick::Draw.new
    text.gravity = Magick::NorthWestGravity
    text.pointsize = 50
    text.font_family = "Comic Sans MS"
    text.font_weight = Magick::BoldWeight
    text.fill = random_rgb
    text
  end

  def y_for_height(height)
    vertical_padding = @image.rows * 0.1
    vertical_top = @image.rows - vertical_padding
    row = 0
    begin
      row = Random.rand(vertical_padding..vertical_top).round
    end while row_occupied?(row, height)
    @occupied << (row..(row + height))
    row
  end

  def row_occupied?(row, height)
    @occupied.each do |range|
      return true if range.include?(row)
      return true if range.include?(row + height)
    end
    false
  end
end
