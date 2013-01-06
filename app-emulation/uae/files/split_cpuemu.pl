#!/usr/bin/perl

open(INPUT, "<cpuemu_6.c");
open(OUT1, ">cpuemu_6.t");
open(OUT2, ">cpuemu_7.c");

$header = 1;
$part = 0;

while ($line = <INPUT>) {

	$size += length($line);

	if (($line =~ /^#/ || $line eq "\n") && ($line ne "#ifdef PART_1\n") && $header) {
		print OUT1 $line;
		print OUT2 $line;
	} else {
	
		$header = 0;
	
		if ($line ne "#ifdef PART_4\n" && $part == 0) {
			print OUT1 $line;
		} else {
			$part = 1;
			print OUT2 $line;
		}
	}
}

close(OUT2);
close(OUT1);
close(INPUT);
