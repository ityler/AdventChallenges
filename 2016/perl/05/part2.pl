#!/usr/local/bin/perl
use strict;
use warnings;
use Digest::MD5 qw/md5_hex/;
# -
# Advent of Code 2016 - Day 5 - Part 2
# - Tyler Normile - #
#   NOTES: 
#   -> The eight-character password for the door is generated one character 
#      at a time by finding the MD5 hash of some Door ID (your puzzle input) 
#      and an increasing integer index (starting with 0).
#   -> Find the first combination of hash and door ID that allow for the
#      hexadecimal representation to start with five zeros (00000XXX)
#   -> The 6th character in the hash is the position of the character in the new password,
#      the 7th character is the actual character in the password
#   -> My example input: ffykfhsq -> 8c35d1ab
# - - - - - - - - - - - - - - - - - - - - - - - - - - #
#   USAGE: perl part2.pl <input string>
# -

my($doorID,$hash,$idx,$pos,$pwd);           # Inits
$doorID = "";                               # User input (Door-ID)
$hash = "";                                 # Hash string
$idx = 0;                                   # Index starting value
$pwd = "--------";                          # Result passsword
$pos = 0;
if(defined($ARGV[0])){                      # Input parameter provided
  $doorID = $ARGV[0];                       # Set door-ID as input
  while(index($pwd,"-") != -1){             # Password not complete
    # Found nex character in password
    while(substr($hash,0,5) !~ m/^00000/){  # Not 'intersting hash' value
      $idx++;                               # Increment index value
      $hash = md5_hex($doorID.$idx);        # Get new hash in hex
      $pos = substr($hash,5,1);             # Get position value
      if($pos =~ /[a-zA-Z]/){               # Not a number (stops not a number warning when comparing within range)
        $pos = -1;                          # Set to -1 to help with comparision within range below
      }
    }
    # - Check that position is within constraints and that the character hasnt already been found
    #   at the position within the password (Not sure if this is necessary, for my input it was)
    if($pos >= 0 && $pos < 8 && substr($pwd,$pos,1) eq "-"){
      print "\n IDX:  ${idx}\n";
      print " Hash: ${hash}\n";
      print " POS:  ${pos}\n";
      substr($pwd,$pos,1) = substr($hash,6,1); # Build password string with position value
      print " PWD:  ${pwd}\n";  
    }
    $idx++;                                 # Reincrement index to start new character search
    $hash = md5_hex($doorID.$idx);          # Get new starting hash for next character
  }
  print "\n Complete PWD: ${pwd}\n";
} else {                                    # No input parameter provided error
  print "\n Error: No input parameter provided\n";  
}