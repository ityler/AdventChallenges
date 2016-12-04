#!/usr/local/bin/perl
use strict;
use warnings;
# -
# Advent of Code 2016 - Day 1 - Part 1
# - Tyler Normile - #
#   North => 0
#   East  => 1
#   South => 2
#   West  => 3
# - - - - - - - - - - - - - - - - - - - - - - - - - - #
#   USAGE: perl part1.pl < inputFilename
# -

my($input) = <>;                # STDIN
my(@data,$look,$x,$y);          # Inits
$x = 0;                         # X distance
$y = 0;                         # Y distance
$look = 0;                      # Start facing North => 0; 
@data = split(", ",$input);     # Split input(comma space) into array
foreach(@data){                 # Each movement order in list
  move($_);                     # Perform movement with input
}
print "\n\n X: ${x}\n";         # Output X distance result
print " Y: ${y}\n\n";           # Output Y distance result
print " Total: ".($x+$y)."\n";  # Output total distance traveled

# - Move direction and distance - #
#   -> Update looking direction
#   -> Track distance traveled across X and Y planes
#   @PARAM: 
#    * Movement direction (L|R) and distance (###) (e.g. R185)
# -
sub move {
  my($movement) = shift;          # Movement parameter (X###)
  my($dir,$dist) = ($movement =~ /^(.{1})(.*)/); # First char in $dir, rest in $dist
  
  # - Change direction - #
  if($dir eq "L"){                # Left direction
    $look--;                      # Decrement looking direction
  } elsif($dir eq "R"){           # Right direction
    $look++;                      # Increment looking direction
  }
  
  # - Adjust looking direction - #
  if($look < 0){ $look = 4 - abs($look); }  # If $look is negative subtract that number form 4
  # Instead of using the absolute value of $look above, could do (4 + $look)
  $look = $look % 4;              # Check for modulus change in direction

  # Adjust distance with direction (think of this as a grid(X,Y))
  if($look == 0){                 # Looking North
    $y = $y + $dist;              # Distance moved North    
  } elsif($look == 1){            # Looking East
    $x = $x + $dist;              # Distance moved East
  } elsif($look == 2){            # Looking South
    $y = $y - $dist;              # Distance moved South
  } elsif($look == 3){            # Looking West
    $x = $x - $dist;              # Distance moved West
  }
}