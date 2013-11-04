use strict;
use warnings;

package ParseArgs;

sub new {
	my ($class, $args) = @_;
	my $self = {};
	bless $self, $class;

	$self->{SCHEMA} = $args;
	$self->{VALUES} = {};
	return $self;
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
				if ($schema->{$switchname} eq 'bool'){
					# write 1 to parsed values
				}
				else {
					my $switcharg = shift @args;
					# Process this arg
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
	#$self->{VALUES} = {@{$self->{ARGS}}};
	# foreach my $arg (@args) {
	# 	if ($arg =~ /^-p/) {
			
	# 	}
	# 	#elsif 
	# 	# $self->{ARGS}
	# }
}

sub Get {
	return 1;
}

1;
