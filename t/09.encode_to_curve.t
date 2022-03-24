use strict;
use warnings;

use Test::More ;
use Crypt::OpenSSL::EC;
use Crypt::OpenSSL::Bignum;
use Crypt::OpenSSL::Hash2Curve qw/expand_message_xmd encode_to_curve get_hash2curve_params/;
use Data::Dump qw/dump/;


my $msg=pack("H*", '1e4350616365503235365f584d443a5348412d3235365f535357555f4e555f0850617373776f7264170000000000000000000000000000000000000000000000160a41696e69746961746f720a42726573706f6e6465721034b36454cab2e7842c389f7d88ecb7df');
my $DST = 'QUUX-V01-CS02-with-P256_XMD:SHA-256_SSWU_NU_';
my $group_name = "prime256v1";
my $type = 'sswu';
my $P = encode_to_curve($msg, $DST, $group_name, $type, 'SHA256', \&Crypt::OpenSSL::Hash2Curve::expand_message_xmd , 0 );

my $params_ref = get_hash2curve_params($group_name, $type);
my $group = $params_ref->[0];
my $ctx = $params_ref->[-1];
my $bn = Crypt::OpenSSL::EC::EC_POINT::point2hex($group, $P, 4, $ctx);
is($bn, '04993B46E30BA9CFC3DC2D3AE2CF9733CF03994E74383C4E1B4A92E8D6D466B321C4A642979162FBDE9E1C9A6180BD27A0594491E4C231F51006D0BF7992D07127', 'encode_to_curve');

done_testing;

