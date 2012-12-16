package OXauth::Controller::Auth;
use Moose;
extends 'OXauth::Controller';

use HTTP::Throwable::Factory qw/ http_throw /;

sub login {
  my( $self , $req ) = @_;

  my $login_error;

  my $username = $req->param( 'username' ) // '';

  if ( $req->method eq 'POST' ) {
    my $user = $self->model->resultset('Users')->find({ username => $username });
    if ( $user and $user->check_passphrase( $req->param( 'password' ))) {
      $req->session->{user_id} = $username;

      my $redir = delete $req->session->{redir_to};
      $redir //= '/';

      http_throw( Found => { location => $redir });
    }
    else { $login_error = 'Wrong user or password' }
  }

  return $self->render(
    'login.tx' , {
      error    => $login_error ,
      title    => 'Login' ,
      username => $username
    });
}

sub logout {
  my( $self , $req ) = @_;

  delete $req->session->{user_id}
    if ( $req->method eq 'POST' );

  http_throw( SeeOther => { location => '/' });
}

__PACKAGE__->meta->make_immutable;
1;
