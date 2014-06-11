#!/usr/bin/env ruby -I.

require 'constants'
require 'resources'
require 'drawer'

module Battleships
  # Battleships game
  class Game < Gosu::Window
    include Constants

    KEY_FUNCS = {
      Gosu::KbEscape =>  -> { close },

      Gosu::MsLeft   =>  -> { @position = Point.new( mouse_x, mouse_y ) }
    }
    
    attr_reader :font, :image

    def initialize
      super( WIDTH, HEIGHT, false, 100 )
      self.caption = 'Battleships'

      load_resources

      @drawer = Drawer.new( self )
      @phase  = :placement
    end

    def needs_cursor?   # Enable the mouse cursor
      true
    end

    def update
    end

    def draw
      @drawer.background
      @drawer.header
      @drawer.title
      @drawer.grids
    end

    def button_down( btn_id )
      instance_exec( &KEY_FUNCS[btn_id] ) if KEY_FUNCS.key? btn_id
    end

    private

    def load_resources
      loader = ResourceLoader.new( self )
      @font   = loader.fonts
      @image  = loader.images
    end
  end
end

Battleships::Game.new.show
