#!perl -w
use strict;
use warnings;
# - 
# Advent of Code 
# Solution Day-Part 9-1 
# LOCATIONS:
# -> Snowdin
# -> AlphaCentauri
# -> Arbre
# -> Norrath
# -> Tambi
# -> Straylight
# -> Tristram
# -> Faerun
# - 
my($inf) = "input.txt";               # Input path/filename
my(%loc) = ();                        # Locations hash
open(my $IN,"<",$inf)                 # Open input file
  or die "Unable to open input file!\n";
  open(my $LOG,">","log")              # Open log file
  or die "Unable to open log file!\n";
my(@strs) = <$IN>;                    # Slurp file into array
close($IN);                           # Close input file
foreach(@strs){                       # Each string in array
  chomp;                              # Strip CRLF ($_)
  my($loc1,$loc2,$dist) = /(\w+) to (\w+) = (\d+)/g;
  print "Loc: ".$loc1. " --> ".$loc2." = ".$dist."\n";
  $loc{$loc1}{$loc2} = $dist;
  $loc{$loc2}{$loc1} = $dist;
}
foreach(keys %loc){
  print $LOG $_."\n";
}
close($LOG);

