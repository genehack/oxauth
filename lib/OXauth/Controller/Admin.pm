package OXauth::Controller::Admin;
use Moose;
extends 'OXauth::Controller';

has '+title' => ( default => 'Admin' );

__PACKAGE__->meta->make_immutable;
1;
