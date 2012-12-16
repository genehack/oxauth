#! /usr/bin/env perl
# PODNAME: app.psgi

use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/lib";

use OXauth;
use YAML    qw/ LoadFile /;

my $config_file = "$FindBin::Bin/oxauth.yaml";
my $config = LoadFile( $config_file ) // {}
  if( -e $config_file );

OXauth->new( $config )->to_app;
