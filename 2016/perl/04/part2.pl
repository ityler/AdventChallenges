#!/usr/local/bin/perl
use strict;
use warnings;
use Data::Dumper;

# -
# Advent of Code 2016 - Day 4 - Part 2
# - Tyler Normile - #
#   NOTES: 
#   -> Determine which encrypted room names are real by valiating against
#      the pre-defined rules for the checksum value []
#   -> Each room consists of an encrypted name (lowercase letters separated by dashes) 
#      followed by a dash, a sector ID, and a checksum in square brackets.
#   -> Checksum is the five most common letters in the encrypted name,
#      ties are broken via alphabetization
#   -> Sum the sector IDs of the real rooms as the solution
# - - - - - - - - - - - - - - - - - - - - - - - - - - #
#   USAGE: perl part2.pl < inputFilename
# -

my(@data,$input,$total,$vcs);
my($vcnt,$icnt);
$vcnt = 0;
$icnt = 0;
$total = 0;                                 # Valid total (sector-ids)
$input = "";                                # Input string init
while(<>){                                  # Get STDIN as input
  $input .= $_;                             # Append to input
}
@data = split(/^/m,$input);                 # Split input(on CRLF) into array
foreach(@data){                             # Each line from input file
  my($rn,$sid,$cs) = $_ =~ /([-a-z]+)(\d+?)(\[.*?\])/; # Split into 3 groupings
  $cs =~ s/([\[\]])//g;                     # Substitute out brackets ([ ])
  print "RN: ${rn}\n";                     # Room name
  print "SID: ${sid}\n";                   # Sector ID
  print "CS: ${cs}\n";                     # Checksum
  $vcs = getChkSum($rn);                    # Calculate room names checksum
  print "VCS: ${vcs}\n\n";
  if($vcs eq $cs){                          # Calculated checksum matches given checksum
    $total += $sid;                         # Add sector-ID's of valid encrypted room names
    $vcnt++;                                # Increment valid count
  } else {
    $icnt++;                                  # Increment invalid count
  }
} # --> End each line in input loop

print "\n Total: ${total}\n";               # Output result total (sum of setor-id's)


# - Calculate encrypted room names' checksum - #
#   @PARAM: 
#    * Encrypted room name            (STRING)
# - - - - - - - - - - - - - - - - - - - #
#   RETURNS: 
#    * Room names 'checksum'
# -
sub getChkSum {
  my($rn) = shift;                  # Input param (STRING)
  my(%count,$z);                    # Inits
  $rn =~ s/-//g;                    # Substitute out (-) characters
  # - Build hash of char(keys) and val(counts)
  foreach my $char(split //, $rn){  # Each character in string
    $count{$char}++;                # Increment character count
  }
  # - Sort hash by key count(H->L) then alphabetically (a-z)
  foreach my $char(sort{$count{$b} <=> $count{$a} or $a cmp $b} keys %count){
    $z .= $char;                    # Append to result string
  }
  return substr($z,0,5);              # Return checksum result(first 5)
}

# - Decrypt Room Name - #
#   @PARAM:
#    * Encrypted room name    (STRING)
#    * Sector ID              (STRING)
# - - - - - - - - - - - - - - - - - - - #
#   -> Use shift cypher w/ to shift characters based on the 
#      sector IDs' value.s
# -
sub decryptRoomName {

} 

# ABCDEFGHIJKLMNOPQRSTUVWXYZ
# 01234567890123456789012345