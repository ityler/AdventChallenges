#!perl -w
use strict;
use warnings;
# - 
# Advent of Code 
# Solution Day-Part 5-1 
# - 
my($ns) = 0;                          # Nice string counter
my($cond) = 0;                        # Condition init
my($inf) = "input.txt";               # Input path/filename
open(my $IN,"<",$inf)                 # Open input file
  or die "Unable to open input file!\n";
open(my $LOG,">","log")               # Open log file
  or die "Unable to open log file!\n";
my(@strs) = <$IN>;                    # Slurp file into array
close($IN);                           # Close input file
foreach(@strs){                       # Each naughty or nice string           
  $cond = 0; 
  my($str) = $_;                      # String in array
  # Check bad requirements first
  if(!($str =~ m/^(ab|cd|pq|xy)/)){   # Does not contain bad substring
    # Check for good requirements
    if($str =~ m/[aeiou].*[aeiou].*[aeiou]/){ # Contains 3 insances of voewls, probably a better way avail than repeating
      print $LOG $str." Three vowels found\n";
      if($str =~ /(.)\1/){            # Contains any duplicate characters
        $cond = 1;                    # Condition is met
      }
      if($cond == 1){                 # Condition is true
        $ns++;
      }
    } # Else bad string
  } # Else bad string
}
print "Nice strings: ".$ns."\n";      # Write out result 
close($LOG);