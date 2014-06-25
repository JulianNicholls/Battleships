# Resource Loader

module Battleships
  # Resource Loader
  class ResourceLoader
    def initialize( window )
      @window = window
    end

    def fonts( filename = 'media/good_times_rg.ttf' )
      return load_font( filename ) if File.readable? filename

      {
        header: Gosu::Font.new( @window, Gosu.default_font_name, 36 ),
        title:  Gosu::Font.new( @window, Gosu.default_font_name, 24 ),
        info:   Gosu::Font.new( @window, Gosu.default_font_name, 16 ),
        button: Gosu::Font.new( @window, Gosu.default_font_name, 14 )
      }
    end

    def images
      {
        waves1: Gosu::Image.new( @window, 'media/waves1.png', true ),
        waves2: Gosu::Image.new( @window, 'media/waves2.png', true ),
        ship:   Gosu::Image.load_tiles( @window, 'media/Ship.png', 30, 30, true )
      }
    end

    def sounds
      {
        hit:  Gosu::Sample.new( @window, 'media/Explosion.wav' ),
        miss: Gosu::Sample.new( @window, 'media/Miss.wav' )
      }
    end

    private

    def load_font( filename )
      {
        header: Gosu::Font.new( @window, filename, 36 ),
        title:  Gosu::Font.new( @window, filename, 24 ),
        info:   Gosu::Font.new( @window, filename, 16 ),
        button: Gosu::Font.new( @window, filename, 14 )
      }
    end
  end
end
