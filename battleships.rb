#! /usr/bin/env ruby -I.

require 'grid'
require 'shiptypes'

class Battleships
  SHIPS = [AircraftCarrier, Battleship, Cruiser, 
           Destroyer, Destroyer, Submarine, Submarine]
           
  def initialize
    @computer_grid  = Grid.new    # ( :visible )  # for now
    @player_grid = Grid.new( :visible )
  end

  def show
    lefts  = @computer_grid.to_s( :headers ).lines
    rights = @player_grid.to_s( :headers ).lines
    
    puts "\n        Computer                      Player"
    lefts.each_with_index do |left, idx|
      puts "#{left.chomp}      #{rights[idx].chomp}"
    end
  end

  def fill_computer
    @computer_ships = []
    @computer_ships_sunk = []
    
    SHIPS.each { |ship| @computer_ships << ship.new( @computer_grid ) }
  end
  
  def fill_user # temporary
    @player_ships = []
    @player_ships_sunk = []
    
    SHIPS.each { |ship| @player_ships << ship.new( @player_grid ) }
  end
  
  def player_play
    print "\nLocation: "
    loc = STDIN.gets.chomp
    puts @computer_grid.attack( loc ) ? 'HIT!' : 'You Missed'
    check_sunk
  end
  
  def check_sunk
    @computer_ships.each do |ship|
      next unless ship.sunk?
      
      unless @computer_ships_sunk.include? ship
        @computer_ships_sunk << ship
        puts "You sunk a #{ship.name}"
      end
    end
  end
end
 
b = Battleships.new

b.fill_computer
b.fill_user

loop do
  b.show
  b.player_play
end
