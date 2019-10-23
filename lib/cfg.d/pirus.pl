=pod

=head1 PIRUS 'PUSH' implementation

The official location for this EPrints extension is L<https://github.com/eprintsug/irus/>.

Please consult the README there for details about this implementation.

If there are any problems or bugs, please open an issue in that GitHub repository.

Released to the public domain (or CC0 depending on your juristiction).

USE OF THIS EXTENSION IS ENTIRELY AT YOUR OWN RISK

=head2 Installation / Implementation 

Please see the L<Installation|https://github.com/eprintsug/irus#installation> 
or L<Implementation|https://github.com/eprintsug/irus#implementation> sections
of the README.

=head2 Changes

For recent changes, please see L<https://github.com/eprintsug/irus#changes>  

1.05 Sebastien Francois <sf2@ecs.soton.ac.uk>

Conform to 2014 guidelines (see Event::PIRUS.pm)

1.02 Justin Bradley <jb4@ecs.soton.ac.uk>

Compatibility fixes for 3.2.

1.01 Tim Brody <tdb2@ecs.soton.ac.uk>

Fixed reference to 'jtitle' instead of 'publication'

1.00 Tim Brody <tdb2@ecs.soton.ac.uk>

Initial version

=cut

require LWP::UserAgent;
require LWP::ConnCache;

# modify the following URL to the PIRUS tracker location
$c->{pirus}->{tracker} = "https://irus.jisc.ac.uk/counter/";
# during testing (or on a test server), the following should be used:
#$c->{pirus}->{tracker} = "https://irus.jisc.ac.uk/counter/test/";

# you may want to revise the settings for the user agent e.g. increase or
# decrease the network timeout
$c->{pirus}->{ua} = LWP::UserAgent->new(
	from => $c->{adminemail},
	agent => $c->{version},
	timeout => 20,
	conn_cache => LWP::ConnCache->new,
);
#$c->{pirus}->{ua}->proxy('https', 'FULL-URL-TO-YOUR-PROXY-SERVER');

$c->{plugins}->{"Event::PIRUS"}->{params}->{disable} = 0;

##############################################################################

$c->add_dataset_trigger( 'access', EPrints::Const::EP_TRIGGER_CREATED, sub {
	my( %args ) = @_;

	my $repo = $args{repository};
	my $access = $args{dataobj};

	my $plugin = $repo->plugin( "Event::PIRUS" );

	my $r = $plugin->log( $access, $repo->current_url( host => 1 ) );

	if( defined $r && !$r->is_success )
	{
		my $fail_message = "PIRUS dataset trigger failed to send data to tracker.\n " . $r->as_string;
		$repo->log( $fail_message );
		my $event = $repo->dataset( "event_queue" )->dataobj_class->create_unique( $repo, {
			eventqueueid => Digest::MD5::md5_hex( "Event::PIRUS::replay" ),
			pluginid => "Event::PIRUS",
			action => "replay",
			description => $fail_message,
		});
		if( defined $event )
		{
			$event->set_value( "params", [$access->id] );
			$event->commit;
		}
	}
});
