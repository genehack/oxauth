package OXauth::Controller;
# ABSTRACT: OXauth Base controller
use Moose;
use 5.010;

has title => (
  is  => 'ro' ,
  isa => 'Str'
);

has model => (
  is       => 'ro' ,
  isa      => 'OXauth::Schema',
  handles  => [ qw/ load_user_from_session / ] ,
  required => 1 ,
);

has view => (
  is       => 'ro' ,
  isa      => 'Text::Xslate' ,
  handles  => [ qw/ render / ] ,
  required => 1 ,
);

sub index {
  my( $self , $req ) = @_;

  return $self->render( 'index.tx' , {
    title => $self->title ,
    user  => $req->session->{user_id} ,
  });
}

__PACKAGE__->meta->make_immutable;
1;
