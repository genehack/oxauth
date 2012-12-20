package OXauth::Schema::Result::Users;
use parent qw/ DBIx::Class::Core /;

use strict;
use warnings;

__PACKAGE__->load_components( qw/ PK::Auto PassphraseColumn / );
__PACKAGE__->table( 'users' );

__PACKAGE__->add_column(
  id => {
    data_type   => 'integer' ,
    is_nullable => 0
  } ,
  username => {
    data_type   => 'varying character' ,
    size        => 255 ,
    is_nullable => 0 ,
  } ,
  password => {
    data_type        => 'text',
    is_nullable      => 0 ,
    passphrase       => 'rfc2307' ,
    passphrase_class => 'BlowfishCrypt' ,
    passphrase_args  => {
      salt_random => 1 ,
      cost        => 14 ,
    },
    passphrase_check_method => 'check_passphrase' ,
  } ,
  name => {
    data_type   => 'varying character',
    size        =>  255 ,
    is_nullable => 1 ,
  } ,
);

__PACKAGE__->set_primary_key( qw/ id / );
__PACKAGE__->add_unique_constraint([ qw/ username / ]);

__PACKAGE__->has_many(
  user_permissions => 'OXauth::Schema::Result::UserPermissions' => 'user_id'
);
__PACKAGE__->many_to_many( permissions => user_permissions => 'permission' );

sub has_permission_to {
  my( $self , $query ) = @_;

  return $self->permissions->search({ name => $query })->count > 0 ? 1 : 0;
}

1;
