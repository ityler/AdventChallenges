#!perl -w
use strict;
use warnings;
# - 
# Advent of Code 
# Solution Day-Part 10-1
# Input -> 3113322113
# - 
open(my $LOG,">","log")               # Open log file
  or die "Unable to open log file!\n";
my(@strs) = <$IN>;                    # Slurp file into array
close($IN);                           # Close input file
foreach(@strs){                       # Each string in array
  chomp;                              # Strip CRLF ($_)
}
close($LOG);                          # Close log file       