#!/usr/bin/perl

use Font::TTF;
use Font::TTF::Font;

if ($#ARGV != 0) {
	warn "Usage: $0 fontfile\n";
	exit 1;
}

$f = Font::TTF::Font->open($ARGV[0]);
$f->{'TSIV'}->read;
($dat = $f->{'TSIV'}->{' dat'})=~s/\r/\n/g;
$dat=~s/\000//g;
print $dat;
