#!/usr/local/bin/perl
use strict;
use warnings;
# -
# Advent of Code 2016 - Day 3 - Part 1
# - Tyler Normile - #
#   NOTES: 
#   -> Determine if given sides from input file meet the
#      rules for a valid triangle
#   -> Each triangle is delimited by a crlf
#   -> The triangles sides are separated by a double space
# - - - - - - - - - - - - - - - - - - - - - - - - - - #
#   USAGE: perl part1.pl < inputFilename
# -

my(@data,$input,$res,@sides,$vt);
$res = 0;                               # Result status
$vt = 0;                                # Valid triangle count
while(<>){                              # Get STDIN as input
  $input .= $_;                         # Append to input
}
@data = split(/^/m,$input);             # Split input(on CRLF) into array
foreach(@data){                         # Each line from input file (set of 3 sides)
  $_ =~ s/^\s+//;                       # Trim whitespace from front of string
  @sides = split(/ {2,}/, $_);          # Split side lengths on doublespace into array
  $res = isTriangle(\@sides);           # Get result of triangle check (pass param by reference)
  if($res){                             # Valid triangle
    $vt++;                              # Increment valid triangle count
  }
}
print "Valid Triangles: ${vt}\n";       # Output result count

# - Determine if sides of shape are a valid triangle - #
#   @PARAM: 
#    * Sides of proposed triangle (ARRAY REF)
# - - - - - - - - - - - - - - - - - - - #
#   RETURNS: 
#    * Triangle status (0|1)
# -
sub isTriangle {
  my(@sides) = @{$_[0]};        # Param (side lengths)
  my($r) = 0;                   # Return result
  if(scalar @sides == 3){       # 3 side lengths in array
    my($s1,$s2,$s3) = @sides;   # Split into individual sides
    if($s1+$s2 > $s3 && $s1+$s3 > $s2 && $s2+$s3 > $s1){ # Meets rules for valid triangle
      $r = 1;                   # Set true result
    }
  }
  return $r;                    # Return result
}