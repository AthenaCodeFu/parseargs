package ParseArgs;
use strict;
use warnings;
no warnings 'uninitialized';
use Moose;

has 'SCHEMA' => (
	is => 'rw',
);
has VALUES => (
	is => 'rw',
	default => sub {{}},
);

sub Parse {
	my ($self, @args) = @_;
	my $schema = $self->{SCHEMA};

	my $capture_next_arg;
	for my $arg (@args) {
		if ($capture_next_arg) {
			$self->{VALUES}{$capture_next_arg} = $arg;
			$capture_next_arg = 0;
		}
		else {
			$arg =~ s/^-//;
			if ($self->SchemaType($arg) eq 'bool') {
				$self->{VALUES}{$arg} = 1;
			}
			else {
				$capture_next_arg = $arg;
			}
		}
	}
}

sub SchemaType {
	my ($self, $arg) = @_;
	$arg =~ s/^-//;
	return $self->{SCHEMA}{$arg};
}

sub Get {
	my ($self, $arg) = @_;
	return $self->{VALUES}{$arg};
}

1;
