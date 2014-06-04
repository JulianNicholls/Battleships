#! /usr/bin/env ruby -I.

require 'grid'

class Battleships
  def initialize
    @cgrid  = Grid.new
    @mygrid = Grid.new( :visible )
  end

  def show
    puts "         Other"
    puts @cgrid.to_s( :headers )

    puts "\n         Player"
    puts @mygrid.to_s( :headers )
  end

  def fill
    @mygrid.set( 'A1' )   ; @cgrid.set( 'A1' )
    @mygrid.set( 'A2' )   ; @cgrid.set( 'A2' )
    @mygrid.set( 'A3' )   ; @cgrid.set( 'A3' )
    @mygrid.set( 'A4' )   ; @cgrid.set( 'A4' )
    @mygrid.set( 'A5' )   ; @cgrid.set( 'A5' )

    @mygrid.set( 'C3' )   ; @cgrid.set( 'C3' )
    @mygrid.set( 'C4' )   ; @cgrid.set( 'C4' )
    @mygrid.set( 'C5' )   ; @cgrid.set( 'C5' )
    @mygrid.set( 'C6' )   ; @cgrid.set( 'C6' )

    @mygrid.set( 'E3' )   ; @cgrid.set( 'E3' )
    @mygrid.set( 'F3' )   ; @cgrid.set( 'F3' )
    @mygrid.set( 'G3' )   ; @cgrid.set( 'G3' )

    @mygrid.set( 'I3' )   ; @cgrid.set( 'I3' )
    @mygrid.set( 'J3' )   ; @cgrid.set( 'J3' )

    @mygrid.set( 'I7' )   ; @cgrid.set( 'I7' )
    @mygrid.set( 'J7' )   ; @cgrid.set( 'J7' )

    @mygrid.set( 'C8' )   ; @cgrid.set( 'C8' )
    @mygrid.set( 'E10' )  ; @cgrid.set( 'E10' )
  end
  
  def attack
    @cgrid.attack( 'A1' ) 
    @cgrid.attack( 'A2' ) 
    @cgrid.attack( 'A3' ) 
    @cgrid.attack( 'A4' ) 
    @cgrid.attack( 'A5' ) 
    @cgrid.attack( 'C3' ) 
    @cgrid.attack( 'D4' ) 
    @cgrid.attack( 'E3' ) 
    @cgrid.attack( 'F3' ) 
    @cgrid.attack( 'G5' ) 
    @cgrid.attack( 'I6' ) 
    @cgrid.attack( 'J6' ) 
    @cgrid.attack( 'J7' )     
    @cgrid.attack( 'C8' ) 
  end
end
 
b = Battleships.new

b.fill
b.attack
b.show
