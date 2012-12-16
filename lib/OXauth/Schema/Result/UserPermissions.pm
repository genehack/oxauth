package OXauth::Schema::Result::UserPermissions;
use parent qw/ DBIx::Class::Core /;

use strict;
use warnings;

__PACKAGE__->table( 'user_permissions' );

__PACKAGE__->add_column(
  user_id => {
    data_type   => 'integer' ,
    is_nullable => 0
  } ,
  permission_id => {
    data_type   => 'varying character',
    size        =>  255 ,
    is_nullable => 0 ,
  } ,
);

__PACKAGE__->set_primary_key( qw/ user_id permission_id / );

__PACKAGE__->belongs_to( 'user' => 'OXauth::Schema::Result::Users' ,
                         { 'foreign.id' => 'self.user_id' });
__PACKAGE__->belongs_to( 'permission' => 'OXauth::Schema::Result::Permissions' ,
                         { 'foreign.id' => 'self.permission_id' });


1;
