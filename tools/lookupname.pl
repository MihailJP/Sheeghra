#!/usr/bin/perl

use integer;

if ($#ARGV != 0) {
	warn "Usage: $0 vtpfile\n";
	exit 1;
}

open(VTP, $ARGV[0]) or die "Cannot open VTP file!\n";
while (<VTP>) {
	if (/^DEF_FEATURE NAME \".+?\" TAG \"(.+?)\"/) {
		$tmp = $1;
	} elsif (/^ LOOKUP /) {
		($lu = $_) =~ s/\" /\"\n /g;
		foreach $lup (split "\n", $lu) {
			$lup =~ / LOOKUP \"(.+?)\"/;
			$lutag{$1} = $tmp;
		}
		undef $tmp;
	} elsif (/^DEF_LOOKUP \"(.+?)\"/) {
		$tmp = $1;
		@anchorTmpList = ();
	} elsif (/^AS_SUBSTITUTION/) {
		push @substList, $tmp;
		undef $tmp;
	} elsif (/^AS_POSITION/) {
		push @posList, $tmp;
	} elsif (/AT ANCHOR \"(.+?)\"/) {
		@tmplst = /AT ANCHOR \"(.+?)\"/g;
		for ($i = 0; $i <= $#tmplst; $i++) {
			$flag = 1;
			foreach $anchorName (@anchorTmpList) {
				$flag = 0 if ($tmplst[$i] eq $anchorName);
			}
			if ($flag) {
				push @anchorTmpList, $tmplst[$i];
				push @anchorList, $tmp."-".$tmplst[$i];
			}
		}
		$tmp = $1;
	}
}

$file = "";
while (<STDIN>) {
	$file .= $_;
	if (/^Lookup: (\d+) \d+ \d+ \"(.+?)\"/) {
		if (($1 - 0) & 0x100) {
			push @posOrigList, $2;
		} else {
			push @substOrigList, $2;
		}
	}
}
for ($i = 0; $i <= $#substList; $i++) {
	$currentTag = $lutag{$substList[$i]} ? "'".$lutag{$substList[$i]}."' " : "";
	$file =~ s/\"$substOrigList[$i]\"/\"$currentTag$substList[$i]\"/gm;
	$file =~ s/\"$substOrigList[$i] subtable\"/\"$substList[$i]\"/gm;
	$file =~ s/\"$substOrigList[$i] contextual (\d+)\"/\"$substList[$i] $1\"/gm;
}
for ($i = 0; $i <= $#posList; $i++) {
	$currentTag = $lutag{$posList[$i]} ? "'".$lutag{$posList[$i]}."' " : "";
	$file =~ s/\"$posOrigList[$i]\"/\"$currentTag$posList[$i]\"/gm;
	$file =~ s/\"$posOrigList[$i] subtable\"/\"$posList[$i]\"/gm;
}
for ($i = 0; $i <= $#anchorList; $i++) {
	$file =~ s/\"Anchor-$i\"/\"$anchorList[$i]\"/gm;
}
print $file;
