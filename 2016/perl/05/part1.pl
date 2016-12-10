#!/usr/local/bin/perl
use strict;
use warnings;
use Digest::MD5 qw/md5_hex/;
# -
# Advent of Code 2016 - Day 5 - Part 1
# - Tyler Normile - #
#   NOTES: 
#   -> The eight-character password for the door is generated one character 
#      at a time by finding the MD5 hash of some Door ID (your puzzle input) 
#      and an increasing integer index (starting with 0).
#   -> Find the first combination of hash and door ID that allow for the
#      hexadecimal representation to start with five zeros (00000XXX)
#   -> My example input: ffykfhsq -> c6697b55
# - - - - - - - - - - - - - - - - - - - - - - - - - - #
#   USAGE: perl part1.pl <input string>
# -

my($doorID,$hash,$idx,$pwd);                # Inits
$doorID = "";                               # User input (Door-ID)
$hash = "";                                 # Hash string
$idx = 0;                                   # Index starting value
$pwd = "";                                  # Result passsword
if(defined($ARGV[0])){                      # Input parameter provided
  $doorID = $ARGV[0];                       # Set door-ID as input
  while(length($pwd) != 8){                 # Not required password length
    while(substr($hash,0,5) !~ m/^00000/){  # Found nex character in password
      $idx++;                               # Increment index value
      $hash = md5_hex($doorID.$idx);        # Get new hash in hex
    }
    print "\n IDX:  ${idx}\n";
    print " Hash: ${hash}\n";
    $pwd .= substr($hash,5,1);              # Build password string
    print " PWD:  ${pwd}\n";
    $idx++;                                 # Reincrement index to start new character search
    $hash = md5_hex($doorID.$idx);          # Get new starting hash for next character
  }
  print "\n Complete PWD: ${pwd}\n";
} else {                                    # No input parameter provided error
  print "\n Error: No input parameter provided\n";  
}