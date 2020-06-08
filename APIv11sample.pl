#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;
use BittrexAPIv11 qw(get_bittrex_api);


print "Begin program:\n";
###############################################################################################
# Global variables
###############################################################################################
    my $api = {
        "apikey" => "",
        "apisecret" => ""
    };

    my $loglevel = 5;

#Sample safe code (no api key required)

    my $currencies = get_bittrex_api("public/getcurrencies", undef, undef, $loglevel-1);
    print " - Loaded ". scalar @{ $currencies->{result} } ." currencies\n";
    print "   Sample output \$currencies->{result}->[0]:\n". Dumper $currencies->{result}->[0];
    my $markets = get_bittrex_api("public/getmarkets", undef, undef, $loglevel-1);
    print " - Loaded ". scalar @{ $markets->{result} } ." markets\n";
    print "   Sample output \$markets->{result}->[0]:\n". Dumper $markets->{result}->[0];

###############################################################################################
#
# Sample commands
#
# Be careful using the code. Careless use of the subs below can result in a loss of money!
#
# Read additional (official) information here: https://bittrex.github.io/api/v3
#
# Donations:
#
# BTC: 17kZJHjouZqLmMwntg2M6zzdEW3Jivx79o
# ETH: 0xda1be63336b49e25201d2f406f01b1989f6146c1
#
###############################################################################################
#
# PUBLIC
#
#
# GET /public/getmarkets
#    my $markets = get_bittrex_api("public/getmarkets", undef, undef, $loglevel);
#    print Dumper $markets->{result};
# GET /public/getcurrencies
#    my $currencies = get_bittrex_api("public/getcurrencies", undef, undef, $loglevel);
#    print Dumper $currencies->{result};
# GET /public/getticker
#    my @query = ("market=USD-BTC");
#    my $ticker = get_bittrex_api("public/getticker", join('&', @query), undef, $loglevel);
#    print Dumper $ticker->{result};
# GET /public/getmarketsummaries
#    my $marketsummaries = get_bittrex_api("public/getmarketsummaries", undef, undef, $loglevel);
#    print Dumper $marketsummaries->{result};
# GET /public/getmarketsummary
#    my @query = ("market=USD-BTC");
#    my $marketsummary = get_bittrex_api("public/getmarketsummary", join('&', @query), undef, $loglevel);
#    print Dumper $marketsummary->{result};
# GET /public/getorderbook
#    my @query = ("market=USD-BTC", "type=both");
#    my $orderbook = get_bittrex_api("public/getorderbook", join('&', @query), undef, $loglevel);
#    print Dumper $orderbook->{result};
# GET /public/getmarkethistory
#    my @query = ("market=USD-BTC");
#    my $markethistory = get_bittrex_api("public/getmarkethistory", join('&', @query), undef, $loglevel);
#    print Dumper $markethistory->{result};
#
# MARKET
#
# GET /market/buylimit
#    my @query = ("market=USD-BTC", "quantity=1.00000000", "rate=10.00000000", "timeInForce=GTC");
#    my $buylimit = get_bittrex_api("market/buylimit", join('&', @query), $api, $loglevel);
#    print Dumper $buylimit->{result};
# GET /market/selllimit
#    my @query = ("market=USD-BTC", "quantity=0.030000000", "rate=12500.00000000", "timeInForce=GTC");
#    my $selllimit = get_bittrex_api("market/selllimit", join('&', @query), $api, $loglevel);
#    print Dumper $selllimit->{result};
# GET /market/cancel
#    my @query = ("uuid=c21xxx5f-9xx7-4xx6-axx9-dxxxxxxxx4");
#    my $cancel = get_bittrex_api("market/cancel", join('&', @query), $api, $loglevel);
#    print Dumper $cancel->{result};
# GET /market/getopenorders
#    my @query = ("market=USD-BTC");
#    my $openorders = get_bittrex_api("market/getopenorders", join('&', @query), $api, $loglevel);
#    print Dumper $openorders->{result};
#
# ACCOUNT
#
# GET /account/getbalances
#    my $balances = get_bittrex_api("account/getbalances", undef, $api, $loglevel);
#    print Dumper $balances->{result};
# GET /account/getbalance
#    my @query = ("currency=USD");
#    my $balance = get_bittrex_api("account/getbalance", join('&', @query), $api, $loglevel);
#    print Dumper $balance->{result};
# GET /account/getdepositaddress
#    my @query = ("currency=BTC");
#    my $depositaddress = get_bittrex_api("account/getdepositaddress", join('&', @query), $api, $loglevel);
#    print Dumper $depositaddress->{result};
# GET /account/withdraw
#    my @query = ("currency=BTC", "quantity=0.0100000", "address=17kZJHjouZqLmMwntg2M6zzdEW3Jivx79o"); #donate address
#    my $withdraw = get_bittrex_api("account/withdraw", join('&', @query), $api, $loglevel);
#    print Dumper $withdraw->{result};
# GET /account/getorder
#    my @query = ("uuid=9xxxxfc3-9x92-45x2-8ex6-03exxx115xx3");
#    my $order = get_bittrex_api("account/getorder", join('&', @query), $api, $loglevel);
#    print Dumper $order->{result};
# GET /account/getorderhistory
#    my @query = ("market=USD-BTC");
#    my $orderhistory = get_bittrex_api("account/getorderhistory", join('&', @query), $api, $loglevel);
#    print Dumper $orderhistory->{result};
# GET /account/getwithdrawalhistory
#    my @query = ("currency=BTC");
#    my $withdrawalhistory = get_bittrex_api("account/getwithdrawalhistory", join('&', @query), $api, $loglevel);
#    print Dumper $withdrawalhistory->{result};
# GET /account/getdeposithistory
#    my @query = ("currency=BTC");
#    my $deposithistory = get_bittrex_api("account/getdeposithistory", join('&', @query), $api, $loglevel);
#    print Dumper $deposithistory->{result};

sub logmessage {
    my $string = $_[0];
    my $loglevel = $_[1];
    if ($loglevel > 5) { print $string; }
}
