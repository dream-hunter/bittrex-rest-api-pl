#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;
use BittrexAPIv3 qw(get_bittrex_api);


print "Begin program:\n";
###############################################################################################
# Global variables
###############################################################################################
    my $api = {
        "apikey" => "",
        "apisecret" => ""
    };

    my $loglevel = 6;

#Sample safe code (no api key required)

#    my $ping = get_ping($loglevel);
#    print " - Server time (frequency of use is restricted): $ping->{serverTime}\n";

    my $currencies = get_currencies(undef, $loglevel);
    print " - Loaded ". scalar @{ $currencies } ." currencies\n";
    print "   Sample output \$currencies->[0]:\n". Dumper $currencies->[0];
    my $markets = get_markets(undef, undef, undef, $loglevel);
    print " - Loaded ". scalar @{ $markets } ." markets\n";
    print "   Sample output \$markets->[0]:\n". Dumper $markets->[0];

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
#ACCOUNT
#
#GET /account
#    my $account = get_account($api, undef, $loglevel);
#    print Dumper $account;
#GET /account/volume
#    my $account = get_account($api, "volume", $loglevel);
#    print Dumper $account;
#
#ADDRESSES
#
#GET /addresses
#    my $addresses = get_addresses($api, undef, $loglevel);
#    print Dumper $addresses;
#POST /addresses
#    my $newAddress = {currencySymbol => "USDT"};
#    my $addresses = post_addresses($api, $newAddress, $loglevel);
#    print Dumper $addresses;
#GET /addresses/{currencySymbol}
#    my $addresses = get_addresses($api, "BTC", $loglevel);
#    print Dumper $addresses;
#
#BALANCES
#
#GET /balances
#    my $balances = get_balances($api, undef, $loglevel);
#    print Dumper $balances;
#HEAD /balances
#    my $balances_head = head_balances($api, $loglevel);
#    print Dumper $balances_head;
#GET /balances/{currencySymbol}
#    my $balances = get_balances($api, "BTC", $loglevel);
#    print Dumper $balances;
#
#CONDITIONAL ORDERS
#
#GET /conditional-orders/{conditionalOrderId}
#    my $conditionalOrderId = "0";
#    my $orders = get_conditional_orders($api, "$conditionalOrderId", undef,$loglevel);
#    print Dumper $orders;
#DELETE /conditional-orders/{conditionalOrderId}
#    my $conditionalOrderId = "";
#    my $orders = del_conditional_orders($api, $conditionalOrderId, $loglevel);
#    print Dumper $orders;
#GET /conditional-orders/open
#    my $orders = get_conditional_orders($api, "open", "marketSymbol=BTC-USD", $loglevel);
#    print Dumper $orders;
#GET /conditional-orders/closed
#    my $orders = get_conditional_orders($api, "closed", "marketSymbol=USD-BTC", $loglevel);
#    print Dumper $orders;
#POST /conditional-orders
#    my $newConditialOrder = {
#        marketSymbol        => "BTC-USD",
#        operand             => "LTE",                       # LTE, GTE - price above (GTE) or below (LTE)
#        triggerPrice        => "8500.0000",                 #
#        orderToCreate       => {                            #
#            marketSymbol    => "BTC-USD",                   #
#            direction       => "BUY",                       # BUY, SELL
#            type            => "LIMIT",                     # LIMIT, MARKET, CEILING_LIMIT, CEILING_MARKET
#            quantity        => "1.000",                     #
#            limit           => "100",                       #
#            timeInForce     => "GOOD_TIL_CANCELLED"         # GOOD_TIL_CANCELLED, IMMEDIATE_OR_CANCEL, FILL_OR_KILL, POST_ONLY_GOOD_TIL_CANCELLED, BUY_NOW
#        }
#    };
#    print Dumper $newConditialOrder;
#    my $orders = post_conditional_orders($api, $newConditialOrder, $loglevel);
#    print Dumper $orders;
#
#CURRENCIES
#
#GET /currencies
#    my $currencies = get_currencies(undef, $loglevel);
#    print Dumper $currencies;
#GET /currencies/{symbol}
#    my $currencies = get_currencies("BTC", $loglevel);
#    print Dumper $currencies;
#
#DEPOSITS
#
#GET /deposits/open
#    my $deposits = get_deposits($api, "open", undef, $loglevel);
#    print Dumper $deposits;
#HEAD /deposits/open
#    my $deposits = head_deposits($api, "open", $loglevel);
#    print Dumper $deposits;
#GET /deposits/closed
#    my $deposits = get_deposits($api, "closed", undef, $loglevel);
#    print Dumper $deposits;
#
#GET /deposits/ByTxId/{txId}
#    my $txId = "";
#    my $deposits = get_deposits($api, "ByTxId/$txId", undef, $loglevel);
#    print Dumper $deposits;
#GET /deposits/{depositId}
#    my $depositId = "";
#    my $deposits = get_deposits($api, "$depositId", undef, $loglevel);
#    print Dumper $deposits;
#
#MARKETS
#
#GET /markets
#    my $markets = get_markets(undef, undef, undef, $loglevel);
#    print Dumper $markets;
#GET /markets/summaries
#    my $markets = get_markets(undef, "summaries", undef, $loglevel);
#    print Dumper $markets;
#HEAD /markets/summaries
#    my $markets = head_markets(undef, "summaries", undef, $loglevel);
#    print Dumper $markets;
#GET /markets/tickers
#    my $markets = get_markets(undef, "tickers", undef, $loglevel);
#    print Dumper $markets;
#HEAD /markets/tickers
#    my $markets = head_markets(undef, "tickers", undef, $loglevel);
#    print Dumper $markets;
#GET /markets/{marketSymbol}/ticker
#    my $markets = get_markets("BTC-USD", "ticker", undef, $loglevel);
#    print Dumper $markets;
#GET /markets/{marketSymbol}
#    my $markets = get_markets("BTC-USD", undef, undef, $loglevel);
#    print Dumper $markets;
#GET /markets/{marketSymbol}/summary
#    my $markets = get_markets("BTC-USD", "summary", undef, $loglevel);
#    print Dumper $markets;
#GET /markets/{marketSymbol}/orderbook
#    my $markets = get_markets("BTC-USD", "orderbook", "depth=25", $loglevel); # depth can be only 1, 25, 500
#    print Dumper $markets;
#HEAD /markets/{marketSymbol}/orderbook
#    my $markets = head_markets("BTC-USD", "orderbook", undef, $loglevel); # depth can be only 1, 25, 500
#    print Dumper $markets;
#GET /markets/{marketSymbol}/trades
#    my $markets = get_markets("BTC-USD", "trades", undef, $loglevel); # depth can be only 1, 25, 500
#    print Dumper $markets;
#HEAD /markets/{marketSymbol}/trade
#    my $markets = head_markets("BTC-USD", "trades", undef, $loglevel); # depth can be only 1, 25, 500
#    print Dumper $markets;
#GET /markets/{marketSymbol}/candles
#    my $markets = get_markets("BTC-USD", "candles", "candleInterval=HOUR_1", $loglevel); # MINUTE_1, MINUTE_5, HOUR_1, DAY_1
#    print Dumper $markets;
#GET /markets/{marketSymbol}/candles/{candleInterval}/recent
#    my $markets = get_markets("BTC-USD", "candles/HOUR_1/recent", undef, $loglevel); # MINUTE_1, MINUTE_5, HOUR_1, DAY_1
#    print Dumper $markets;
#HEAD /markets/{marketSymbol}/candles/{candleInterval}/recent
#    my $markets = head_markets("BTC-USD", "candles/HOUR_1/recent", undef, $loglevel); # MINUTE_1, MINUTE_5, HOUR_1, DAY_1
#    print Dumper $markets;
#GET /markets/{marketSymbol}/candles/{candleInterval}/historical/{year}/{month}/{day}
#    my $markets = get_markets("BTC-USD", "candles/HOUR_1/historical/2020/4/12", undef, $loglevel); # MINUTE_1, MINUTE_5, HOUR_1, DAY_1
#    print Dumper $markets;
#
#ORDERS
#
#GET /orders/closed
#    my $orders = get_orders($api, "closed", "marketSymbol=BTC-USD", $loglevel);
#    print Dumper $orders;
#GET /orders/open
#    my $orders = get_orders($api, "open", "marketSymbol=BTC-USD", $loglevel);
#    print Dumper $orders;
#HEAD /orders/open
#    my $orders = head_orders($api, "open", undef, $loglevel);
#    print Dumper $orders;
#GET /orders/{orderId}
#    my $orderId = "";
#    my $orders = get_orders($api, $orderId, undef, $loglevel);
#    print Dumper $orders;
#DELETE /orders/{orderId}
#    my $orderId = "";
#    my $orders = del_orders($api, $orderId, undef, $loglevel);
#    print Dumper $orders;
#POST /orders
#    my $newOrder = {
#        marketSymbol  => "BTC-USD",            #
#        direction     => "BUY",                # BUY, SELL
#        type          => "LIMIT",              # LIMIT, MARKET, CEILING_LIMIT, CEILING_MARKET
#        quantity      => "1.000",              #
#        limit         => "10.000",             #
#        timeInForce   => 'GOOD_TIL_CANCELLED'  #GOOD_TIL_CANCELLED, IMMEDIATE_OR_CANCEL, FILL_OR_KILL, POST_ONLY_GOOD_TIL_CANCELLED, BUY_NOW
#    };
#    my $orders = post_orders($api, $newOrder, $loglevel);
#    print Dumper $orders;
#
#PING
#
#GET /ping
#    my $ping = get_ping($loglevel);
#    print Dumper $ping;
#
#
#SUBACCOUNTS - NOT A REGULAR FUNCTION! FOR BITTREX PARTNERS ONLY!
#
#GET /subaccounts
#    my $query = "nextPageToken='string'&previousPageToken='string'&pageSize=Int32";
#    my $subaccounts = get_subaccounts($api, undef, $query, $loglevel);
#    print Dumper $subaccounts;
#POST /subaccounts
#    my $newSubaccount = {
#        toSubaccountId  => "string (uuid)",
#        toMasterAccount => "boolean",
#        id              => "string (uuid)",
#        requestId       => "string (uuid)",
#        currencySymbol  => "string",
#        amount          => "number (double)",
#        executedAt      => "string (date-time)"
#    };
#    my $subaccounts = post_subaccounts($api, $newSubaccount, $loglevel);
#    print Dumper $subaccounts;
#GET /subaccounts/{subaccountId}
#    my $subaccountId = "string";
#    my $subaccounts = get_subaccounts($api, $subaccountId, undef, $loglevel);
#    print Dumper $subaccounts;
#
#TRANSFERS - NOT A REGULAR FUNCTION! FOR BITTREX PARTNERS ONLY!
#
#GET /transfers/sent
#    my $query = "toSubaccountId='string'&toMasterAccount=boolean&currencySymbol=string&nextPageToken='string'
#                &previousPageToken='string'&pageSize=Int32&startDate='string'&endDate='string'";
#    my $transfers = get_transfers($api, "sent", $query, $loglevel);
#    print Dumper $transfers;
#GET /transfers/received
#    my $query = "toSubaccountId='string'&toMasterAccount=boolean&currencySymbol=string&nextPageToken='string'
#                &previousPageToken='string'&pageSize=Int32&startDate='string'&endDate='string'";
#    my $transfers = get_transfers($api, "received", $query, $loglevel);
#    print Dumper $transfers;
#GET /transfers/{transferId}
#    my $transferId = "";
#    my $transfers = get_transfers($api, $transferId, undef, $loglevel);
#    print Dumper $transfers;
#POST /transfers
#    my $newTransfer = {
#        toSubaccountId => "string (uuid)",
#        requestId => "string (uuid)",
#        currencySymbol => "string",
#        amount => "number (double)",
#        toMasterAccount => "boolean"
#    };
#    my $transfers = post_transfers($api, $newTransfer, $loglevel);
#    print Dumper $transfers;
#
#WITHRDRAWALS
#
#GET /withdrawals/open
#    my $withdrawals = get_withdrawals($api, "open", undef, $loglevel);
#    print Dumper $withdrawals;
#GET /withdrawals/closed
#    my $withdrawals = get_withdrawals($api, "closed", undef, $loglevel);
#    print Dumper $withdrawals;
#GET /withdrawals/ByTxId/{txId}
#    my $txId = "";
#    my $withdrawals = get_withdrawals($api, "ByTxId/$txId", undef, $loglevel);
#    print Dumper $withdrawals;
#GET /withdrawals/{withdrawalId}
#    my $withdrawalId = "";
#    my $withdrawals = get_withdrawals($api, $withdrawalId, undef, $loglevel);
#    print Dumper $withdrawals;
#DELETE /withdrawals/{withdrawalId}
#    my $withdrawalId = "";
#    my $withdrawals = del_withdrawals($api, $withdrawalId, $loglevel);
#    print Dumper $withdrawals;
#POST /withdrawals
#    my $walletid = "";
#    my $newWithdrawal = {
#        currencySymbol   => "XZC",
#        quantity         => "0.4",
#        cryptoAddress    => $walletid
#    };
#    my $withdrawals = post_withdrawals($api, $newWithdrawal, $loglevel);
#    print Dumper $withdrawals;
#GET /withdrawals/whitelistAddresses
#    my $withdrawals = get_withdrawals($api, "whitelistAddresses", undef, $loglevel);
#    print Dumper $withdrawals;
#
###############################################################################################
# Subs
###############################################################################################

sub get_account {
    my $api = $_[0];
    my $accountPath = $_[1];
    my $loglevel = $_[2];
    my $result = undef;
    my $apiRequest = "account";
    if (defined $accountPath) {
        $apiRequest .= "/$accountPath";
    }
    if (!defined $loglevel || $loglevel < 0 || $loglevel > 10) {
        $loglevel = 1;
    }
    $result = get_bittrex_api($apiRequest, undef, $api, "GET", $loglevel-1);
    if (defined $result) {
        return $result;
    } else {
        logmessage("\nget_account - error", $loglevel);
        return undef;
    }
}

sub get_addresses {
    my $api = $_[0];
    my $addressesPath = $_[1];
    my $loglevel = $_[2];
    my $result = undef;
    my $apiRequest = "addresses";
    if (defined $addressesPath) {
        $apiRequest .= "/$addressesPath";
    }
    if (!defined $loglevel || $loglevel < 0 || $loglevel > 10) {
        $loglevel = 1;
    }
    $result = get_bittrex_api($apiRequest, undef, $api, "GET", $loglevel-1);
    if (defined $result) {
        return $result;
    } else {
        logmessage("\nget_addresses - error", $loglevel);
        return undef;
    }
}

sub post_addresses {
    my $api = $_[0];
    my $newAddress = $_[1];
    my $loglevel = $_[2];
    my $result = undef;
    my $apiRequest = "addresses";
    if (!defined $loglevel || $loglevel < 0 || $loglevel > 10) {
        $loglevel = 1;
    }
    $result = get_bittrex_api($apiRequest, $newAddress, $api, "POST", $loglevel-1);
    if (defined $result) {
        return $result;
    } else {
        logmessage("\npost_addressess - error", $loglevel);
        return undef;
    }
}

sub get_balances {
    my $api = $_[0];
    my $balancesPath = $_[1];
    my $loglevel = $_[2];
    my $result = undef;
    my $apiRequest = "balances";
    if (defined $balancesPath) {
        $apiRequest .= "/$balancesPath";
    }
    if (!defined $loglevel || $loglevel < 0 || $loglevel > 10) {
        $loglevel = 1;
    }
    $result = get_bittrex_api($apiRequest, undef, $api, "GET", $loglevel-1);
    if (defined $result) {
        return $result;
    } else {
        logmessage("\nget_balances - error", $loglevel);
        return undef;
    }
}

sub head_balances {
    my $api = $_[0];
    my $loglevel = $_[1];
    my $result = undef;
    my $apiRequest = "balances";
    if (!defined $loglevel || $loglevel < 0 || $loglevel > 10) {
        $loglevel = 1;
    }
    $result = get_bittrex_api($apiRequest, undef, $api, "HEAD", $loglevel-1);
    if (defined $result) {
        return $result;
    } else {
        logmessage("\nhead_balances - error", $loglevel);
        return undef;
    }
}

sub del_conditional_orders {
    my $api = $_[0];
    my $conditionalOrdersPath = $_[1];
    my $loglevel = $_[2];
    my $result = undef;
    my $apiRequest = "conditional-orders";
    if (defined $conditionalOrdersPath) {
        $apiRequest .= "/$conditionalOrdersPath";
    }
    if (!defined $loglevel || $loglevel < 0 || $loglevel > 10) {
        $loglevel = 1;
    }
    $result = get_bittrex_api($apiRequest, undef, $api, "DELETE", $loglevel-1);
    if (defined $result) {
        return $result;
    } else {
        logmessage("\ndel_conditional_orders - error", $loglevel);
        return undef;
    }
}

sub get_conditional_orders {
    my $api = $_[0];
    my $ordersPath = $_[1];
    my $ordersQuery = $_[2];
    my $loglevel = $_[3];
    my $result = undef;
    my $apiRequest = "conditional-orders";
    if (defined $ordersPath) {
        $apiRequest .= "/$ordersPath";
    }
    if (defined $ordersQuery) {
        $apiRequest .= "?$ordersQuery";
    }
    if (!defined $loglevel || $loglevel < 0 || $loglevel > 10) {
        $loglevel = 1;
    }
    $result = get_bittrex_api($apiRequest, undef, $api, "GET", $loglevel-1);
    if (defined $result) {
        return $result;
    } else {
        logmessage("\nget_conditional - error", $loglevel);
        return undef;
    }
}

sub post_conditional_orders {
    my $api = $_[0];
    my $conditionalOrdersBody = $_[1];
    my $loglevel = $_[2];
    my $result = undef;
    my $apiRequest = "conditional-orders";
    if (!defined $loglevel || $loglevel < 0 || $loglevel > 10) {
        $loglevel = 1;
    }
    $result = get_bittrex_api($apiRequest, $conditionalOrdersBody, $api, "POST", $loglevel-1);
    if (defined $result) {
        return $result;
    } else {
        logmessage("\npost_conditional_orders - error", $loglevel);
        return undef;
    }
}

sub get_currencies {
    my $currencySymbol = $_[0];
    my $loglevel = $_[1];
    my $result = undef;
    my $apiRequest = "currencies";
    if (defined $currencySymbol) {
        $apiRequest .= "/$currencySymbol";
    }
    if (!defined $loglevel || $loglevel < 0 || $loglevel > 10) {
        $loglevel = 1;
    }
    $result = get_bittrex_api($apiRequest, undef, undef, "GET", $loglevel-1);
    if (defined $result) {
        return $result;
    } else {
        logmessage("\nget_currencies - error", $loglevel);
        return undef;
    }
}

sub get_deposits {
    my $api = $_[0];
    my $depositsPath = $_[1];
    my $depositsQuery = $_[2];
    my $loglevel = $_[3];
    my $result = undef;
    my $apiRequest = "deposits";
    if (defined $depositsPath) {
        $apiRequest .= "/$depositsPath";
    }
    if (defined $depositsQuery) {
        $apiRequest .= "?$depositsQuery";
    }
    if (!defined $loglevel || $loglevel < 0 || $loglevel > 10) {
        $loglevel = 1;
    }
    $result = get_bittrex_api($apiRequest, undef, $api, "GET", $loglevel-1);
    if (defined $result) {
        return $result;
    } else {
        logmessage("\nget_deposits - error", $loglevel);
        return undef;
    }
}

sub head_deposits {
    my $api = $_[0];
    my $depositsPath = $_[1];
    my $loglevel = $_[2];
    my $result = undef;
    my $apiRequest = "deposits";
    if (defined $depositsPath) {
        $apiRequest .= "/$depositsPath";
    }
    if (!defined $loglevel || $loglevel < 0 || $loglevel > 10) {
        $loglevel = 1;
    }
    $result = get_bittrex_api($apiRequest, undef, $api, "HEAD", $loglevel-1);
    if (defined $result) {
        return $result;
    } else {
        logmessage("\nhead_deposits - error", $loglevel);
        return undef;
    }
}

sub get_markets {
    my $marketSymbol = $_[0];
    my $marketPath = $_[1];
    my $marketQuery = $_[2];
    my $loglevel = $_[3];
    my $result = undef;
    my $apiRequest = "markets";
    if (defined $marketSymbol) {
        $apiRequest .= "/$marketSymbol";
    }
    if (defined $marketPath) {
        $apiRequest .= "/$marketPath";
    }
    if (defined $marketQuery) {
        $apiRequest .= "?$marketQuery";
    }
    if (!defined $loglevel || $loglevel < 0 || $loglevel > 10) {
        $loglevel = 1;
    }
    $result = get_bittrex_api($apiRequest, undef, undef, "GET", $loglevel-1);
    if (defined $result) {
        return $result;
    } else {
        logmessage("\nget_markets - error", $loglevel);
        return undef;
    }
}

sub head_markets {
    my $marketSymbol = $_[0];
    my $marketPath = $_[1];
    my $marketQuery = $_[2];
    my $loglevel = $_[3];
    my $result = undef;
    my $apiRequest = "markets";
    if (defined $marketSymbol) {
        $apiRequest .= "/$marketSymbol";
    }
    if (defined $marketPath) {
        $apiRequest .= "/$marketPath";
    }
    if (defined $marketQuery) {
        $apiRequest .= "?$marketQuery";
    }
    if (!defined $loglevel || $loglevel < 0 || $loglevel > 10) {
        $loglevel = 1;
    }
    $result = get_bittrex_api($apiRequest, undef, undef, "HEAD", $loglevel-1);
    if (defined $result) {
        return $result;
    } else {
        logmessage("\nhead_markets - error", $loglevel);
        return undef;
    }
}

sub del_orders {
    my $api = $_[0];
    my $ordersPath = $_[1];
    my $ordersQuery = $_[2];
    my $loglevel = $_[3];
    my $result = undef;
    my $apiRequest = "orders";
    if (defined $ordersPath) {
        $apiRequest .= "/$ordersPath";
    }
    if (defined $ordersQuery) {
        $apiRequest .= "?$ordersQuery";
    }
    if (!defined $loglevel || $loglevel < 0 || $loglevel > 10) {
        $loglevel = 1;
    }
    $result = get_bittrex_api($apiRequest, undef, $api, "DELETE", $loglevel-1);
    if (defined $result) {
        return $result;
    } else {
        logmessage("\ndel_orders - error", $loglevel);
        return undef;
    }
}

sub head_orders {
    my $api = $_[0];
    my $ordersPath = $_[1];
    my $ordersQuery = $_[2];
    my $loglevel = $_[3];
    my $result = undef;
    my $apiRequest = "orders";
    if (defined $ordersPath) {
        $apiRequest .= "/$ordersPath";
    }
    if (defined $ordersQuery) {
        $apiRequest .= "?$ordersQuery";
    }
    if (!defined $loglevel || $loglevel < 0 || $loglevel > 10) {
        $loglevel = 1;
    }
    $result = get_bittrex_api($apiRequest, undef, $api, "HEAD", $loglevel-1);
    if (defined $result) {
        return $result;
    } else {
        logmessage("\nhead_orders - error", $loglevel);
        return undef;
    }
}

sub get_orders {
    my $api = $_[0];
    my $ordersPath = $_[1];
    my $ordersQuery = $_[2];
    my $loglevel = $_[3];
    my $result = undef;
    my $apiRequest = "orders";
    if (defined $ordersPath) {
        $apiRequest .= "/$ordersPath";
    }
    if (defined $ordersQuery) {
        $apiRequest .= "?$ordersQuery";
    }
    if (!defined $loglevel || $loglevel < 0 || $loglevel > 10) {
        $loglevel = 1;
    }
    $result = get_bittrex_api($apiRequest, undef, $api, "GET", $loglevel-1);
    if (defined $result) {
        return $result;
    } else {
        logmessage("\nget_orders - error", $loglevel);
        return undef;
    }
}

sub post_orders {
    my $api = $_[0];
    my $ordersBody = $_[1];
    my $loglevel = $_[2];
    my $result = undef;
    my $apiRequest = "orders";
    if (!defined $loglevel || $loglevel < 0 || $loglevel > 10) {
        $loglevel = 1;
    }
    $result = get_bittrex_api($apiRequest, $ordersBody, $api, "POST", $loglevel-1);
    if (defined $result) {
        return $result;
    } else {
        logmessage("\npost_orders - error", $loglevel);
        return undef;
    }
}

sub get_ping {
    my $loglevel = $_[0];
    my $apiRequest = "ping";
    my $result = undef;
    if (!defined $loglevel || $loglevel < 0 || $loglevel > 10) {
        $loglevel = 1;
    }
    $result = get_bittrex_api($apiRequest, undef, undef, "GET", $loglevel-1);
    if (defined $result) {
        return $result;
    } else {
        logmessage("\nget_ping - error", $loglevel);
        return undef;
    }
}

sub get_subaccounts {
    my $api = $_[0];
    my $subaccountsPath = $_[1];
    my $subaccountsQuery = $_[2];
    my $loglevel = $_[3];
    my $result = undef;
    my $apiRequest = "subaccounts";
    if (defined $subaccountsPath) {
        $apiRequest .= "/$subaccountsPath";
    }
    if (defined $subaccountsQuery) {
        $apiRequest .= "?$subaccountsQuery";
    }
    if (!defined $loglevel || $loglevel < 0 || $loglevel > 10) {
        $loglevel = 1;
    }
    $result = get_bittrex_api($apiRequest, undef, $api, "GET", $loglevel-1);
    if (defined $result) {
        return $result;
    } else {
        logmessage("\nget_subaccounts - error", $loglevel);
        return undef;
    }
}

sub post_subaccounts {
    my $api = $_[0];
    my $subaccountsBody = $_[1];
    my $loglevel = $_[2];
    my $result = undef;
    my $apiRequest = "subaccounts";
    if (!defined $loglevel || $loglevel < 0 || $loglevel > 10) {
        $loglevel = 1;
    }
    $result = get_bittrex_api($apiRequest, $subaccountsBody, $api, "POST", $loglevel-1);
    if (defined $result) {
        return $result;
    } else {
        logmessage("\npost_subaccounts - error", $loglevel);
        return undef;
    }
}

sub get_transfers {
    my $api = $_[0];
    my $transfersPath = $_[1];
    my $transfersQuery = $_[2];
    my $loglevel = $_[3];
    my $result = undef;
    my $apiRequest = "transfers";
    if (defined $transfersPath) {
        $apiRequest .= "/$transfersPath";
    }
    if (defined $transfersQuery) {
        $apiRequest .= "?$transfersQuery";
    }
    if (!defined $loglevel || $loglevel < 0 || $loglevel > 10) {
        $loglevel = 1;
    }
    $result = get_bittrex_api($apiRequest, undef, $api, "GET", $loglevel-1);
    if (defined $result) {
        return $result;
    } else {
        logmessage("\nget_transfers - error", $loglevel);
        return undef;
    }
}

sub post_transfers {
    my $api = $_[0];
    my $transfersBody = $_[1];
    my $loglevel = $_[2];
    my $result = undef;
    my $apiRequest = "transfers";
    if (!defined $loglevel || $loglevel < 0 || $loglevel > 10) {
        $loglevel = 1;
    }
    $result = get_bittrex_api($apiRequest, $transfersBody, $api, "POST", $loglevel-1);
    if (defined $result) {
        return $result;
    } else {
        logmessage("\npost_transfers - error", $loglevel);
        return undef;
    }
}

sub get_withdrawals {
    my $api = $_[0];
    my $withdrawalsPath = $_[1];
    my $withdrawalsQuery = $_[2];
    my $loglevel = $_[3];
    my $result = undef;
    my $apiRequest = "withdrawals";
    if (defined $withdrawalsPath) {
        $apiRequest .= "/$withdrawalsPath";
    }
    if (defined $withdrawalsQuery) {
        $apiRequest .= "?$withdrawalsQuery";
    }
    if (!defined $loglevel || $loglevel < 0 || $loglevel > 10) {
        $loglevel = 1;
    }
    $result = get_bittrex_api($apiRequest, undef, $api, "GET", $loglevel-1);
    if (defined $result) {
        return $result;
    } else {
        logmessage("\nget_withdrawals - error", $loglevel);
        return undef;
    }
}

sub del_withdrawals {
    my $api = $_[0];
    my $withdrawalsPath = $_[1];
    my $loglevel = $_[2];
    my $result = undef;
    my $apiRequest = "withdrawals";
    if (defined $withdrawalsPath) {
        $apiRequest .= "/$withdrawalsPath";
    }
    if (!defined $loglevel || $loglevel < 0 || $loglevel > 10) {
        $loglevel = 1;
    }
    $result = get_bittrex_api($apiRequest, undef, $api, "DELETE", $loglevel-1);
    if (defined $result) {
        return $result;
    } else {
        logmessage("\ndel_withdrawals - error", $loglevel);
        return undef;
    }
}

sub post_withdrawals {
    my $api = $_[0];
    my $withdrawalsBody = $_[1];
    my $loglevel = $_[2];
    my $result = undef;
    my $apiRequest = "withdrawals";
    if (!defined $loglevel || $loglevel < 0 || $loglevel > 10) {
        $loglevel = 1;
    }
    $result = get_bittrex_api($apiRequest, $withdrawalsBody, $api, "POST", $loglevel-1);
    if (defined $result) {
        return $result;
    } else {
        logmessage("\npost_withdrawals - error", $loglevel);
        return undef;
    }
}

sub logmessage {
    my $string = $_[0];
    my $loglevel = $_[1];
    if ($loglevel > 5) { print $string; }
}

