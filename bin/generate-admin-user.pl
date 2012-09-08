#!/usr/bin/env perl
  
use strict;
use warnings;
  
use Dancer ':script';
use Dancer::Plugin::Passphrase;
use The::Api::Schema::User;
use Data::Printer;
  
Mongoose->db(%{config->{mongo}});

my $passphrase = passphrase('devpass')->generate_hash;
  
my $input = {
             "created_by" => 'admin',
             "username"   => 'admin',
             "first_name" => 'Ad',
             "last_name"  => 'Min',
             "email"      => 'admin',
             "password"   => $passphrase->{'rfc2307'},
            };
  
my $user = The::Api::Schema::User->new($input);
$user->{permissions}->{admin} = 1;
p($input);
my $id = $user->save();
