#!/usr/local/bin/perl
use strict;
use warnings;
# -
# Advent of Code 2016 - Day 6 - Part 2
# - Tyler Normile - #
#   NOTES: 
#   -> The input consists of 'repitition code' type of messages
#   -> Determine which character is most frequent for each position by column
#   -> For part 2 we want the opposite of part 1, the least occurance letter in each message column
# - - - - - - - - - - - - - - - - - - - - - - - - - - #
#   USAGE: perl part2.pl < inputFilename
# -
open(my $OUT,">","out.log")
  or die "Unable to open output file $!";
my(@data,$input,%msgs);
@data = ();                                 # Input array
$input = "";                                # Input string
%msgs = ();                                 # Messages hash with character counts
while(<>){                                  # Get STDIN as input
  $input .= $_;                             # Append to input
}
if(length($input) != 0){                    # Input was provided
  @data = split(/^/m,$input);               # Split input(on CRLF) into array
  foreach(@data){                           # Each line from input file
    my(@tmp) = split("",$_);                # Split each character into array
    for(my $i = 0; $i <= $#tmp-1; $i++){    # Iterate over each character in message
      $msgs{$i}{$tmp[$i]}++;                # Increment count for position and character
    }
  }
  my($z,$res);
  $res = "--------";
  foreach my $key(keys %msgs){
    $z = "";
    foreach my $char(sort{$msgs{$key}{$a} <=> $msgs{$key}{$b}} keys $msgs{$key}){
      print "${key} --> ${char}\n";
      $z .= $char;
    }
    substr($res,$key,1) = substr($z,0,1);
  }
  print "RES: ${res}\n";
  # caqfbzlh
} else {                                    # No input provided
  print "\n Error: No input data provided\n"; # Write out input error message
}