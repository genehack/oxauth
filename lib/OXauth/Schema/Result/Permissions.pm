package OXauth::Schema::Result::Permissions;
use parent qw/ DBIx::Class::Core /;

use strict;
use warnings;

__PACKAGE__->load_components( 'PK::Auto' );
__PACKAGE__->table( 'permissions' );

__PACKAGE__->add_column(
  id => {
    data_type   => 'integer' ,
    is_nullable => 0
  } ,
  name => {
    data_type   => 'varying character',
    size        =>  255 ,
    is_nullable => 0 ,
  } ,
);

__PACKAGE__->set_primary_key( qw/ id / );
__PACKAGE__->add_unique_constraint([ qw/ name / ]);

1;
