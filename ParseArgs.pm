use strict;
use warnings;

package ParseArgs;

my %defaultvalues = (
	num => 0,
	bool => 0,
	str => '',
);

my $datatyperegex = join('|', keys %defaultvalues);

sub new {
	my ($class, $args) = @_;
	my $self = {};
	bless $self, $class;

	$self->{SCHEMA} = $args;
	return $self;
}

sub Parse {
	my ($self, @args) = @_;
	my $schema = $self->{SCHEMA};

	$self->PopulateDefaultValues();

	while (@args) {
		my $arg = shift @args;

		# command-line switch
		if ($arg =~ /^-/) {
			my $switchname = substr($arg, 1);
			if ($schema->{$switchname}) {
				if ($schema->{$switchname} eq 'bool'){
					$self->{VALUES}{$switchname} = 1;
				}
				else {
					my $switcharg = shift @args;
	  				if ($schema->{$switchname} =~ /^@($datatyperegex)(.)$/) {
						my ($datatype, $delimiter) = ($1, $2);
						$self->{VALUES}{$switchname} = [split(/$delimiter/, $switcharg)];
					}
					else {
						$self->{VALUES}{$switchname} = $switcharg;
					}
				}
			}
			else {
				die "invalid switch name $switchname";
			}
		}
		else {
			die "Not a valid switch: $arg";
		}
	}
}

sub PopulateDefaultValues {
	my ($self) = @_;

	foreach my $switchname (keys %{$self->{SCHEMA}}) {
		my $datatype = $self->{SCHEMA}{$switchname};
		if ($datatype =~ /^@/) {
			$self->{VALUES}{$switchname} = [];
		}
		else {
			$self->{VALUES}{$switchname} = $defaultvalues{$datatype};
		}
	}
}

sub Get {
	my ($self, $key) = @_;
	return $self->{VALUES}{$key};
}

1;
