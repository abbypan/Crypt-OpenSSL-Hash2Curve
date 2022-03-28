#!/usr/bin/perl
use utf8;
use Test::More;
#use Data::Dump qw/dump/;
use bignum;

use Crypt::OpenSSL::Hash2Curve qw/hash_to_field expand_message_xmd/;

my $res;

my $msg=pack("H*", '1e4350616365503235365f584d443a5348412d3235365f535357555f4e555f0850617373776f7264170000000000000000000000000000000000000000000000160a41696e69746961746f720a42726573706f6e6465721034b36454cab2e7842c389f7d88ecb7df');
my $cnt=1;
my $DST = 'QUUX-V01-CS02-with-P256_XMD:SHA-256_SSWU_NU_';
my $p_hex = 'ffffffff00000001000000000000000000000000ffffffffffffffffffffffff';
my $p = Crypt::OpenSSL::Bignum->new_from_hex($p_hex);
my $m =1;
my $k = 0x80;
my @res = hash_to_field( $msg, $cnt, $DST, $p, $m, $k, 'SHA256', \&expand_message_xmd );
is($res[0][0]->to_hex(), "EA083A886A38EF4D15D95BD6A4B4D65620D3C57E4ED00E09FD2D67D67AFD0797", "hash_to_field");

done_testing();
