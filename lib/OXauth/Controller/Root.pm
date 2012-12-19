package OXauth::Controller::Root;
use Moose;
extends 'OXauth::Controller';

has '+title' => ( default => 'Index' );

__PACKAGE__->meta->make_immutable;
1;
