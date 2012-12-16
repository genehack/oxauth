package OXauth::Role::Auth;
use Moose::Role;

use HTTP::Throwable::Factory qw/ http_throw /;

requires 'load_user_from_session';

sub needs_auth {
  my( $self , $req , $redir ) = @_;

  return if $req->session->{user_id};

  $req->session->{redir_to} = $redir || '/' ;
  http_throw( Found => { location => '/login' });
}

sub needs_perm {
  my( $self , $req , $perm , $redir ) = @_;

  $self->needs_auth( $req , $redir );

  my $user = $self->load_user_from_session( $req->session );

  return if $user->has_permission_to( $perm );

  http_throw( Found => { location => '/denied' });
}

1;
