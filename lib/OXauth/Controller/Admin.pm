package OXauth::Controller::Admin;
use Moose;
extends 'OXauth::Controller';
with 'OXauth::Role::Auth';

has '+title' => ( default => 'Admin' );

around 'index' => sub {
  my( $orig , $self , $req ) = @_;

  $self->needs_perm( $req , 'admin' , $req->uri_for( $req->mapping ) );

  $self->$orig( $req );
};

__PACKAGE__->meta->make_immutable;
1;
