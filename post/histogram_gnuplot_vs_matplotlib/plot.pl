#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

use File::Temp;

my $text_color = '#a0caf5';
my $bg_color = '#101f2f';
my $gnuplot_style = <<"EOF";
load 'style_torbosite.gp'
set term svg size 800,600 background bg_color fontscale 1.2
EOF

my $s = do {local(@ARGV, $/) = 'index.md'; <>};
while ($s =~ /^`shellhist_([^.]*).(gp|py)`:\n\n((?: .*\n|\n)+)/mg) {
    my ($chart_name, $filetype, $contents) = ($1, $2, $3);
    $contents =~ s/^ {4}//gm;
    print "$chart_name, $filetype\n";
    my $tmp = File::Temp->new();
    my $svg = "shellhist_$chart_name.svg";


    if ($filetype eq 'gp') {
        print {$tmp} $gnuplot_style, $contents;
        close $tmp or die "$!";
        system("gnuplot $tmp >$svg");
        $? and die "error running gnuplot for $chart_name: $?";
    } elsif ($filetype eq 'py') {
        my $styled_contents = ($contents =~ s{^plt.savefig\(([^)]*)\)}{plt.savefig($1, facecolor='$bg_color', edgecolor='$text_color', padinches=0)}mr);
        print {$tmp} $styled_contents;
        close $tmp or die "$!";
        system("python $tmp");
        $? and die "error running python for $chart_name: $?";
    } else {
        die "bad filetype: $filetype"
    }
}
