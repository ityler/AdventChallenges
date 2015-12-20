#!perl
use strict;
use warnings;
use JSON;
use Data::Dumper;
# - 
# Advent of Code 
# Solution Day-Part 12-2
# - 
my($inf) = "input.txt";               # Input path/filename
my($res) = 0;                         # Result
open(my $IN,"<",$inf)                 # Open input file
  or die "Unable to open input file!\n";
open(my $LOG,">","log")               # Open log file
  or die "Unable to open input file!\n";
my($dat) = <$IN>;                     # Input data
close($IN);                           # Close input file
my($json) = JSON->new;                # JSON object
my($do) = $json->decode($dat);        # Get json from file
print $LOG &Dumper($do)."\n";
print $do->[][]{'green'}."\n";
close($LOG);