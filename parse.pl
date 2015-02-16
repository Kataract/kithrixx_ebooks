#!/usr/bin/env perl

use strict;
use warnings;

use Mojo::DOM;
use Mojo::UserAgent;
use File::Slurp;
use Scalar::Util qw/blessed/;
use DDP;

# Read in a list of links (eventually) and parse the given DOMs for the
# posts we want.

my $infile = './in.txt';
open ( my $fh, "< :encoding(UTF-8)", $infile ) or die "Cannot open $infile for reading: $!";

# Infile should consist of a series of links.  Read each line and then pull the
# resulting DOM into a Mojo object.
my @blockquotes;
while ( <$fh> ) {
	chomp;
	my $link = $_;

	my $ua = Mojo::UserAgent->new;
	my $tx = $ua->get($link);

	# Steal the posts
	# Looking for:
	# <li id="" class="message staff" data-author="Kithrixx">
	# <blockquote class="messageText ugc baseHtml">
	# ...
	# </blockquote>
	# </li>
	my $li_elements = $tx->res->dom->find('li[data-author=Kithrixx]');

	# Collection should consist of li elements, loop over them to make a collection
	# of blockquotes
	my @lis = $li_elements->each;
	foreach my $e ( @lis ) {
		my $blockquote = $e->at('blockquote[class^=messageText]');
		next unless $blockquote;
		my $content = $blockquote->text . " ";
		push @blockquotes, $content;
	}
}

write_file( './out.txt', { binmode => ':utf8' }, @blockquotes );
