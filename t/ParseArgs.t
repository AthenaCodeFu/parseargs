#!/usr/bin/local/perl
use v5.16;
use Athena::Lib;

use Test::More;
use ParseArgs;

my $parser;

$parser = ParseArgs->new({
	l => 'bool',
	p => 'num',
	d => 'str',
	x => 'bool',
	y => 'num',
	z => 'str',
});

$parser->Parse(qw(-l -p 8080 -d /usr/logs));

is ($parser->Get('l'), 1, 'reads a boolean');
is ($parser->Get('p'), 8080, 'reads a number');
# is ($parser->Get('d'), "/usr/logs", 'reads a string');
# not_ok ($parser->Get('x'), 'default bool is false');
# is ($parser->Get('y'), 0, 'default num is false');
# is ($parser->Get('z'), '', 'default str is false');


done_testing();
