require "mini_magick"
require "tempfile"
require_relative "model"

module NSFW
  class Image
    class << self
      def model
        @_model ||= NSFW::Model.new(lazy: true)
      end
    end

    DIMENSIONS   = "224x224"
    PIXEL_NORMAL = 255
    
    attr_accessor :img

    def initialize(image_path)
      @img = MiniMagick::Image.open(image_path)
    end

    def self.prepare!(image_path)
      img = new(image_path)
      img.process!
      img
    end

    def process!
      @img.colorspace("RGB")
        .resize("#{DIMENSIONS}^")
        .crop("#{DIMENSIONS}+0+0","-gravity", "center")
        .write(Tempfile.new.path)
      @img
    end

    def dimensions
      @img.dimensions
    end

    def pixels
      @_pixels ||= @img.get_pixels
    end
    
    def tensor
      @_normalized_pixels ||= normalize_pixels!(pixels)
    end

    def self.safe?(image_path)
      img = self.prepare!(image_path)
      model.safe?(img)
    end

    def self.unsafe?(image_path)
      !self.safe?(image_path)
    end

    def self.predictions(image_path)
      img = self.prepare!(image_path)
      model.predict(img.tensor)
    end

    private

    # Resize to the dimensions needed by the model (244px x 244px)
    def resize!
      @img.resize("#{DIMENSIONS}^")
    end

    # Crop to 244x244 after resizing
    def crop!
      @img.crop("#{DIMENSIONS}")
    end

    # Save to tmpfile
    def stash!
      @img.write()
    end

    # Normalize pixels between 0-1
    def normalize_pixels!(pixel_tensor)
      if pixel_tensor.is_a?(Integer)
        return pixel_tensor.to_f/PIXEL_NORMAL.to_f
      else
        return pixel_tensor.map{ |a| normalize_pixels!(a) }
      end

      # tensor.map do |i|
      #   i.map do |j|
      #     j.map do |k| 
      #       k.to_f / 255.0
      #     end
      #   end
      # end
    end
  end
end