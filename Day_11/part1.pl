#!perl
use strict;
use warnings;
# - 
# Advent of Code 
# Solution Day-Part 11-1
# NOTES: 
#  -> Can not contain (i,o,l)
#  -> Streak of 3 characters in password (abc,stu)
#  -> Two different character pairs (aa,bb)
#  -> Increment current password 1 step starting from right->left
# - 
open(my $LOG,">","log")                 # Open log file
  or die "Unable to open log file!\n";  # Write out error
my($inp) = "vzbxkghb";                  # Current password(puzzle input)
my(@arr) = ("a".."z");                  # alphabet array
my($rm) = 0;                            # Requirements met flag
my($ns) = "";                           # Init new string
my($t) = 0;                             # Changes counter
$ns = $inp;
while($rm != 1){                        # Requirements not yet met
  $t++;                                 # Iterate change counter
  my(@tmp) = split("",$ns);             # Split into character array
  $ns = "";                             # Reset new password string
  for(my $i=$#tmp; $i >= 0;$i--){       # Start at rightmost charcter and work left
    if($tmp[$i] eq "z"){
      $ns.=  "a";
    } else {
      $ns .= ++$tmp[$i];  
    }
  }
  $ns = reverse($ns);
  print "String1: ".$inp."\n";
  print "String2: ".$ns."\n";
  $rm = reqChk($ns);                   # Check requirements
}  
print "\n\n Complete!\n\n";
print " New password: ".$ns."\n";
print " Iterations made: ".$t."\n\n";
close($LOG);                            # Close log file

# - Determine if all password requirements are met
sub reqChk{
  my($pass) = shift;  # Passed parameter
  my($z) = 0;
  # ** BAD ** 
  # Contains (i,o,l)
  if(!($pass =~ m/(i|o|l)/)){    
    $z = 1;
  }
  return $z;
}