package Bitcoin::Crypto::Role::Network;

use Modern::Perl "2010";
use Moo::Role;
use Types::Standard qw(InstanceOf);
use Scalar::Util qw(blessed);

use Bitcoin::Crypto::Network;
use Bitcoin::Crypto::Exception;

use namespace::clean;

has "network" => (
	is => "rw",
	isa => InstanceOf["Bitcoin::Crypto::Network"],
	default => sub {
		return Bitcoin::Crypto::Network->get;
	},
	writer => "_set_network"
);

sub set_network
{
	my ($self, $network) = @_;
	if (ref $network eq "") {
		$network = Bitcoin::Crypto::Network->get($network);
	}

	Bitcoin::Crypto::Exception::NetworkConfig->raise(
		"set_network only accepts Bitcoin::Crypto::Network instances or their ids"
	) unless blessed $network && $network->isa("Bitcoin::Crypto::Network");

	$self->_set_network($network);
	return $self;
}

1;
