package OXauth::Schema;
use parent qw/ DBIx::Class::Schema /;

use strict;
use warnings;

__PACKAGE__->load_namespaces();

sub load_user {
  my( $self , $id ) = @_;

  return $self->resultset( 'Users' )->find({
    username => $id
  });
}

1;
