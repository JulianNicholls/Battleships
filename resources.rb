# Resource Loader

module Battleships
  # Resource Loader
  class ResourceLoader
    def initialize(window)
      @window = window
    end

    def fonts(filename = 'media/good_times_rg.ttf')
      return load_font(filename) if File.readable? filename

      default = Gosu.default_font_name

      {
        header: Gosu::Font.new(@window, default, 36),
        title:  Gosu::Font.new(@window, default, 24),
        info:   Gosu::Font.new(@window, default, 16),
        button: Gosu::Font.new(@window, default, 14)
      }
    end

    def images
      {
        waves1: Gosu::Image.new('media/waves1.png'),
        waves2: Gosu::Image.new('media/waves2.png'),
        ship:   Gosu::Image.load_tiles('media/Ship.png', 30, 30)
      }
    end

    def sounds
      {
        hit:  Gosu::Sample.new('media/Explosion.wav'),
        miss: Gosu::Sample.new('media/Miss.wav')
      }
    end

    private

    def load_font(filename)
      {
        header: Gosu::Font.new(@window, filename, 36),
        title:  Gosu::Font.new(@window, filename, 24),
        info:   Gosu::Font.new(@window, filename, 16),
        button: Gosu::Font.new(@window, filename, 14)
      }
    end
  end
end
