#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

sub writefile {
    my $filename = shift;
    open(my $fh, '>', $filename) or die "$!";
    print $fh @_;
}

my $s = do { local(@ARGV, $/) = 'index.md'; <> } ;
my $text_color = '#a0caf5';
my $style = <<"EOF";
set style line 50 lt 1 lc rgb "$text_color" lw 1
set border ls 50
set xlabel textcolor rgb "$text_color"
set ylabel textcolor rgb "$text_color"
set key textcolor rgb "$text_color"
set title textcolor rgb "$text_color"
EOF

while ($s =~ /^`(shellhist-[^.]*.gnuplot)`:\n\n((?: .*\n|\n)+)/mg) {
    my ($filename, $contents) = ($1, $2);
    writefile($filename, $style, $contents);
    my $svg = ($filename =~ s/\.gnuplot$/.svg/r);
    qx/gnuplot -e 'set term svg size 800,600' $filename >$svg/;
    $? and die "error running gnuplot: $?";
    unlink $filename or die "$!";
}
