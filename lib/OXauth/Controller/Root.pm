package OXauth::Controller::Root;
use Moose;
extends 'OXauth::Controller';

has '+title' => ( default => 'Index' );

sub deny {
  my( $self , $req ) = @_;

  return $req->new_response(
    content => $self->render( 'denied.tx' ,
                              { title => 'Access Denied' ,
                                user  => $req->session->{user_id} }) ,
    status  => '403',
  );
}

__PACKAGE__->meta->make_immutable;
1;
