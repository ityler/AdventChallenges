#!perl
use strict;
use warnings;
use JSON;
use Data::Dumper;
# - 
# Advent of Code 
# Solution Day-Part 13-1
# - 
my($inf) = "input.txt";               # Input path/filename
my($res) = 0;                         # Result
open(my $IN,"<",$inf)                 # Open input file
  or die "Unable to open input file!\n";
open(my $LOG,">","log")               # Open log file
  or die "Unable to open input file!\n";
my($dat) = <$IN>;                     # Input data
close($IN);                           # Close input file
close($LOG);