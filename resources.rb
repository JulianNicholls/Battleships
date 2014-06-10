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
        moves:  Gosu::Font.new( @window, Gosu.default_font_name, 24 ),
        header: Gosu::Font.new( @window, Gosu.default_font_name, 36 ),
        title:  Gosu::Font.new( @window, Gosu.default_font_name, 24 ),
        info:   Gosu::Font.new( @window, Gosu.default_font_name, 30 )
      }
    end

    def images
      {
        waves1: Gosu::Image.new( @window, 'media/waves1.png', true ),
        waves2: Gosu::Image.new( @window, 'media/waves2.png', true )
      }
    end

    def sounds
      {
        flip: Gosu::Sample.new( @window, 'media/Blip.wav' ),
        tada: [Gosu::Sample.new( @window, 'media/tada.wav' ),
               Gosu::Sample.new( @window, 'media/alleluia.wav' ),
               Gosu::Sample.new( @window, 'media/shazam2.wav' ),
               Gosu::Sample.new( @window, 'media/ww_kewl.wav' ),
               Gosu::Sample.new( @window, 'media/yeehaw.wav' )]
      }
    end

    private

    def load_font( filename )
      {
        moves:  Gosu::Font.new( @window, filename, 24 ),
        header: Gosu::Font.new( @window, filename, 36 ),
        title:  Gosu::Font.new( @window, filename, 24 ),
        info:   Gosu::Font.new( @window, filename, 30 )
      }
    end
  end
end
