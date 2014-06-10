#!/usr/bin/env ruby -I.

require 'constants'
require 'resources'
require 'drawer'

module Battleships
  # Battleships game
  class Game < Gosu::Window
    include Constants

    attr_reader :font, :image

    def initialize
      super( WIDTH, HEIGHT, false, 100 )
      self.caption = 'Battleships'

      load_resources

      @drawer = Drawer.new( self )
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
      close if btn_id == Gosu::KbEscape
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
