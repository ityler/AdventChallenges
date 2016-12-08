#!/usr/local/bin/perl
use strict;
use warnings;
use Data::Dumper;

# -
# Advent of Code 2016 - Day 3 - Part 2
# - Tyler Normile - #
#   NOTES: 
#   -> Determine if given sides from input file meet the
#      rules for a valid triangle
#   -> Each triangle is each value through 3 rows in columns rather than by each row
#   -> Build hash of triangle data, we will increment our counts every 3 rows.
#   -> This allows each triangles sides to be added to the %matrix hash
# - - - - - - - - - - - - - - - - - - - - - - - - - - #
#   USAGE: perl part2.pl < inputFilename
# -

my(@data,$i,$input,$res,@sides,$t,$v,$vt);  # Inits
my(%matrix);                                # Data hash of triangles sides
$res = 0;                                   # Result status
$vt = 0;                                    # Valid triangle count
$t = 1;                                     # Triangle reference counter (increment with $v every 3)
$v = 1;                                     # Triangle total counter 
$i = 1;                                     # Side counter (1..3)
while(<>){                                  # Get STDIN as input
  $input .= $_;                             # Append to input
}
@data = split(/^/m,$input);                 # Split input(on CRLF) into array
foreach(@data){                             # Each line from input file
  $_ =~ s/^\s+//;                           # Trim whitespace from front of string
  $_ =~ s/[\x0A\x0D]//g;                    # Remove crlf from end of string
  @sides = split(/ {2,}/, $_);              # Split side lengths on doublespace into array
  $matrix{"T".$t}{"S${i}"} = $sides[0];     # Side of first side of first triangle
  $matrix{"T".($t+1)}{"S${i}"} = $sides[1]; # Next side of second triangle       
  $matrix{"T".($t+2)}{"S${i}"} = $sides[2]; # Next side of third triangle        
  $v++;                                     # Increment triangle Count
  $i++;                                     # Increment side counter
  if($i > 3){                               # Reset counters when all 3 sides reached
    $i = 1;                                 # Side counter reset
    $t = $v;                                # Reset hash key to match current record counter
  }
} # --> End each line in input loop
foreach my $key (keys %matrix){             # Each triangle in hash
  my(@tmp) = values $matrix{$key};          # Get each value of triangle into array 
  $res = isTriangle(\@tmp);                 # Get result of triangle check (pass param by reference)
  if($res){                                 # Valid triangle
    $vt++;                                  # Increment valid triangle count
  }  
}
print "Valid Triangles: ${vt}\n";           # Output result count

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