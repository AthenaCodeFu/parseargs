use strict;
use warnings;

package ParseArgs;

sub new {
	my ($class, $args) = @_;
	my $self = {};
	bless $self, $class;

	$self->{SCHEMA} = $args;
	$self->{VALUES} = $self->_LoadDefaults();
	return $self;
}

sub _LoadDefaults {
	my ($self, $flag) = @_;
	my %defaultvalues;

	for my $switchname (keys $self->{SCHEMA}) {
		if ($self->{SCHEMA}{$switchname} =~ /num/i) {
			$defaultvalues{$switchname} = 0;
		}
		else {
			$defaultvalues{$switchname} = '';
		}
	}
	
	return \%defaultvalues;
}

sub Parse {
	my ($self, @args) = @_;
	my $schema = $self->{SCHEMA};

	while (@args) {
		my $arg = shift @args;

		# command-line switch
		if ($arg =~ /^-/) {
			my $switchname = substr($arg, 1);
			if ($schema->{$switchname}) {
				# Boolean switches default to true if present
				if ($schema->{$switchname} eq 'bool'){
					$self->{VALUES}{$switchname} = 1;
				}
				else {
					my $switcharg = shift @args;
					$self->{VALUES}{$switchname} = $switcharg;
				}
			}
			else {
				die "invalid switch name $switchname";
			}
		}
		# arg to switch
		else {
			die "Not a valid switch: $arg";
		}
	}
}

sub Get {
	my ($self, $flag) = @_;
	return $self->{VALUES}{$flag};
}

1;
