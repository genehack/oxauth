package OXauth::Schema;
use parent qw/ DBIx::Class::Schema /;

use strict;
use warnings;

__PACKAGE__->load_namespaces();

sub load_user_from_session {
  my( $self , $session ) = @_;

  return $self->resultset( 'Users' )->find({
    username => $session->{user_id}
  }) or die "Couldn't find user based on id";
}

1;
