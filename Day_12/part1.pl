#!perl
use strict;
use warnings;
# - 
# Advent of Code 
# Solution Day-Part 12-1
# - 
my($inf) = "input.txt";               # Input path/filename
open(my $IN,"<",$inf)                 # Open input file
  or die "Unable to open input file!\n";
close($IN);                           # Close input file