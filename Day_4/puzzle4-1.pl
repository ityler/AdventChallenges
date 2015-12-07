#!perl -w
use strict;
use warnings;
use Digest::MD5 qw/md5_hex/;

my($input,$val);
my($x) = 0;
$val = '99';
$input = 'iwrupvqb';
while ($val !~ m/^00000/) {
  $x++;
  $val = md5_hex($input.$x);
}
print "Part 1 - Answer: ".$x."\n";

# Part two of challenge
$x = 0;
while ($val !~ m/^000000/) {
  $x++;
  $val = md5_hex($input.$x);
}
print "Part 2 - Answer: ".$x."\n";