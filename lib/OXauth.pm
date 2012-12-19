package OXauth;
# ABSTRACT: OX advent auth example
use OX;
use 5.010;

use OXauth::Schema;

has connect_info => ( is => 'ro', isa => 'ArrayRef' , required => 1 );

has model => (
  is           => 'ro' ,
  isa          => 'OXauth::Schema' ,
  dependencies => [ 'connect_info' ] ,
  lifecycle    => 'Singleton' ,
  block        => sub {
    OXauth::Schema->connect( @{ shift->param( 'connect_info' )} )
  } ,
);

has cache_dir     => ( is => 'ro' , isa => 'Str' , required => 1 );
has template_root => ( is => 'ro' , isa => 'Str' , required => 1 );

has view => (
  is           => 'ro' ,
  isa          => 'Text::Xslate' ,
  dependencies => {
    cache_dir => 'cache_dir' ,
    path      => 'template_root' ,
  },
);

has admin_controller => (
  is    => 'ro' ,
  isa   => 'OXauth::Controller::Admin' ,
  infer => 1 ,
);

has auth_controller => (
  is    => 'ro' ,
  isa   => 'OXauth::Controller::Auth' ,
  infer => 1 ,
);

has root_controller => (
  is    => 'ro',
  isa   => 'OXauth::Controller::Root' ,
  infer => 1 ,
);

router as {
  wrap 'Plack::Middleware::Session' => ( store => literal( 'File' ));

  wrap_if( sub { $_[0]->{PATH_INFO} =~ m{^/admin} },
           'OXauth::Middleware::Auth' => ( model => 'model' ));

  route '/'       => 'root_controller.index';
  route '/login'  => 'auth_controller.login' , ( name => 'login' );
  route '/logout' => 'auth_controller.logout';
  route '/admin'  => 'admin_controller.index';
};

__PACKAGE__->meta->make_immutable;
1;
