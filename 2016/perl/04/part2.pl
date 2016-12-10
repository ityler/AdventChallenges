#!/usr/local/bin/perl
use strict;
use warnings;
use Data::Dumper;

# -
# Advent of Code 2016 - Day 4 - Part 2
# - Tyler Normile - #
#   NOTES: 
#   -> Determine which encrypted room names are real by valiating against
#      the pre-defined rules for the checksum value [].
#   -> Each room consists of an encrypted name (lowercase letters separated by dashes) 
#      followed by a dash, a sector ID, and a checksum in square brackets.
#   -> Checksum is the five most common letters in the encrypted name,
#      ties are broken via alphabetization.
#   -> If valid room via checksum, decrypt name by shifting each charcter the value of 
#      the rooms sector ID. i.e(A->B , Z->A) 
# - - - - - - - - - - - - - - - - - - - - - - - - - - #
#   USAGE: perl part2.pl < inputFilename
# -

# - Uncomment the 2 lines below and print $LOG lines to see each valid room names conversion - #
# open(my $OUT,">","out.log")
#   or die "Unable to open output file $!";
my(@data,$input,$nn,$total,$vcs);           # Inits
$input = "";                                # Input string init
while(<>){                                  # Get STDIN as input
  $input .= $_;                             # Append to input
}
@data = split(/^/m,$input);                 # Split input(on CRLF) into array
print "\n";                                 # Output formatter
foreach(@data){                             # Each line from input file
  my($rn,$sid,$cs) = $_ =~ /([-a-z]+)(\d+?)(\[.*?\])/; # Split into 3 groupings
  $cs =~ s/([\[\]])//g;                     # Substitute out brackets ([ ])
  $vcs = getChkSum($rn);                    # Calculate room names checksum
  if($vcs eq $cs){                          # Calculated checksum matches given checksum
    $nn = decryptRoomName($rn,$sid);        # Decrypt room name
#   print $OUT "Room Name: ${rn} -> ${nn}\n";
    if(index($nn,"northpole") != -1){       # See if keyword is found in name(CHALLENGE KEYWORD)
      print " Match:     ${nn}\n";          # Output decrypted room name
      print " Sector-ID: ${sid}\n\n";       # Output sector ID (solution)
    }
  }
} # --> End each line in input loop
#close($OUT);

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
  return substr($z,0,5);            # Return checksum result(first 5)
}

# - Decrypt room name - #
#   @PARAM:
#    * Encrypted room name    (STRING)
#    * Sector ID              (STRING)
# - - - - - - - - - - - - - - - - - - - #
#   -> Use shift cypher to shift characters based on the 
#      sector IDs' value
# -
sub decryptRoomName {
  my($roomname,$sectorID) = @_;         # Passed parameters (room name, sectorID)
  my(@chars) = split("",$roomname);     # Each character from room name in array for the decrypt
  my($realName);                        # Decrypted room name
  foreach(@chars){                      # Each character in room name
    # Convert dash ( - ) character to space per decrypt - #
    if($_ eq "-"){                      # Found space
      $realName .= " ";                 # Add space to decrypted name
    } else {                            # Shift decrypt on letter
      $realName .= shiftChar($_,$sectorID); # Get new shifted character (decrypted)
    }
  }
  return $realName;                     # Return descrypted room name
} 

# - Shift character over the specified number of characters - #
#    ABCDEFGHIJKLMNOPQRSTUVWXYZ
#    01234567890123456789012345
#   @PARAM:
#    * Encrypted room name    (STRING)
#    * Sector ID              (STRING)
# - - - - - - - - - - - - - - - - - - - #
#   RETURNS: 
#    * Decrypted character    (CHAR)
# - 
sub shiftChar {
  my($char,$mult) = @_;               # Get parameter of (start char and shift counter) 
  my(@alphas) = ("a"..."z");          # Possible characters
  my($res) = "";                      # Shifted result character
  my($idx) = grep { $alphas[$_] eq $char } (0 .. @alphas-1); # Get index value of starting character
  if($idx != -1){                     # Found in alphas array (should always be true)
      $res = $alphas[($idx + $mult) % 26]; # New shifted character with modulus
  }
  return $res;                        # Return result
}