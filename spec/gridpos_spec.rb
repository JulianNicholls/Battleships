require 'minitest/autorun'
require 'minitest/pride'

require './gridpos'

# Battleships module
module Battleships
  describe GridPos do
    describe 'GridPos.next' do
      it 'should move to the next column in the middle' do
        GridPos.next( 'G1', :across ).must_equal 'G2'
        GridPos.next( 'G5', :across ).must_equal 'G6'
        GridPos.next( 'G9', :across ).must_equal 'G10'
      end

      it 'should move to the next row in the middle' do
        GridPos.next( 'A5', :down ).must_equal 'B5'
        GridPos.next( 'D5', :down ).must_equal 'E5'
        GridPos.next( 'I5', :down ).must_equal 'J5'
      end

      it 'should accept lower-case' do
        GridPos.next( 'g9', :across ).must_equal 'G10'
        GridPos.next( 'i5', :down ).must_equal 'J5'
      end

      it 'should return nil if there is no next' do
        GridPos.next( 'G10', :across ).must_be_nil
        GridPos.next( 'J3', :down ).must_be_nil
      end

      it 'should reject bad locations' do
        GridPos.next( 'A11', :down ).must_be_nil
        GridPos.next( 'A0', :down ).must_be_nil
        GridPos.next( 'K1', :across ).must_be_nil
      end
    end

    describe 'GridPos.prev' do
      it 'should move to the prev column in the middle' do
        GridPos.prev( 'G2', :across ).must_equal 'G1'
        GridPos.prev( 'G5', :across ).must_equal 'G4'
        GridPos.prev( 'G10', :across ).must_equal 'G9'
      end

      it 'should move to the prev row in the middle' do
        GridPos.prev( 'B5', :down ).must_equal 'A5'
        GridPos.prev( 'D5', :down ).must_equal 'C5'
        GridPos.prev( 'J5', :down ).must_equal 'I5'
      end

      it 'should accept lower-case' do
        GridPos.prev( 'g10', :across ).must_equal 'G9'
        GridPos.prev( 'j5', :down ).must_equal 'I5'
      end

      it 'should return nil if there is no prev' do
        GridPos.prev( 'G1', :across ).must_be_nil
        GridPos.prev( 'A3', :down ).must_be_nil
      end

      it 'should reject bad locations' do
        GridPos.prev( 'A11', :down ).must_be_nil
        GridPos.prev( 'A0', :down ).must_be_nil
        GridPos.prev( 'K1', :across ).must_be_nil
      end
    end

    describe '#GridPos.neighbours' do
      it 'should return all four neighbours for a middle location' do
        GridPos.neighbours( 'B5' ).must_equal %w(B4 B6 A5 C5)
      end

      it 'should return three neighbours for a top location' do
        GridPos.neighbours( 'A5' ).must_equal %w(A4 A6 B5)
      end

      it 'should return three neighbours for a left location' do
        GridPos.neighbours( 'B1' ).must_equal %w(B2 A1 C1)
      end

      it 'should return three neighbours for a right location' do
        GridPos.neighbours( 'B10' ).must_equal %w(B9 A10 C10)
      end

      it 'should return three neighbours for a bottom location' do
        GridPos.neighbours( 'J5' ).must_equal %w(J4 J6 I5)
      end

      it 'should return just two neighbours for a corner location' do
        GridPos.neighbours( 'A1' ).must_equal %w(A2 B1)
        GridPos.neighbours( 'A10' ).must_equal %w(A9 B10)
        GridPos.neighbours( 'J1' ).must_equal %w(J2 I1)
        GridPos.neighbours( 'J10' ).must_equal %w(J9 I10)
      end
    end
  end
end
