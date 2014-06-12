#! /usr/bin/env ruby -I.

require 'term/ansicolor'

require 'grid'
require 'shiptypes'

module Battleships
  # Text version of Battleships
  class Game
    include Term::ANSIColor

    SHIPS = [AircraftCarrier, Battleship, Cruiser,
             Destroyer, Destroyer, Submarine, Submarine]

    def initialize
      @computer_grid = Grid.new    # ( :visible )  # for now
      @player_grid   = Grid.new( :visible )

      @player_ships_sunk   = []
      @computer_ships_sunk = []

      fill_computer
    end

    def show
      lefts  = @computer_grid.to_s( :headers ).lines
      rights = @player_grid.to_s( :headers ).lines

      puts bright_cyan, "\n        Computer                      Player", white
      lefts.each_with_index do |left, idx|
        puts "#{left.chomp}      #{rights[idx].chomp}"
      end
    end

    def fill_user # temporary
      SHIPS.each { |ship| @player_grid.add_ship ship.new( @player_grid ) }
    end

    def player_play
      print bright_white, "\nLocation: "
      loc = STDIN.gets.chomp
      puts @computer_grid.attack( loc ) ? 'HIT!' : 'You Missed'
      check_sunk
    end

    private

    def fill_computer
      SHIPS.each { |ship| @computer_grid.add_ship ship.new( @computer_grid ) }
    end

    def check_sunk
      (@computer_grid.ships - @computer_ships_sunk).each do |ship|
        next unless ship.sunk?

        @computer_ships_sunk << ship
        puts "You sunk a #{ship.type}"
      end
    end
  end
end

b = Battleships::Game.new

b.fill_user

loop do
  b.show
  b.player_play
end
