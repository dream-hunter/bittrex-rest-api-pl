#!/usr/bin/perl

use lib '.';
use strict;
use warnings;
use Data::Dumper;
use BittrexAPIv3 qw(
    get_bittrex_api
    get_account
    get_addresses
    post_addresses
    get_balances
    head_balances
    post_batch
    del_conditional_orders
    get_conditional_orders
    post_conditional_orders
    head_conditional_orders
    get_currencies
    get_deposits
    head_deposits
    get_executions
    head_executions
    get_funds_transfer_methods
    get_markets
    head_markets
    del_orders
    head_orders
    get_orders
    post_orders
    get_ping
    get_subaccounts
    post_subaccounts
    get_transfers
    post_transfers
    get_withdrawals
    del_withdrawals
    post_withdrawals
);


print "Begin program:\n";
###############################################################################################
# Global variables
###############################################################################################
    my $loglevel = 10;
# Getting command line, include -apikey and -apisecret
    my @args = split("-",join(" ", @ARGV));
    shift(@args);
    my $params = {
        "apikey" => "",
        "apisecret" => ""
    };

    foreach my $parameter (values @args) {
        my @str = split (" ", $parameter);
        $params->{"$str[0]"} = $str[1];
    }
    print Dumper $params;
#Sample safe code (no api key required)

#    my $ping = get_ping($loglevel);
#    print " - Server time (frequency of use is restricted): $ping->{serverTime}\n";

#    my $currencies = get_currencies(undef, $loglevel);
#    print " - Loaded ". scalar @{ $currencies } ." currencies\n";
#    print "   Sample output \$currencies->[0]:\n". Dumper $currencies->[0];
#    my $markets = get_markets(undef, undef, undef, $loglevel);
#    print " - Loaded ". scalar @{ $markets } ." markets\n";
#    print "   Sample output \$markets->[0]:\n". Dumper $markets->[0];

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
#    my $account = get_account($params, undef, $loglevel);
#    print Dumper $account;
#
#GET /account/fees/trading
#    my $account = get_account($params, "fees/trading", $loglevel);
#    print Dumper $account;
#
#GET /account/fees/trading/{marketSymbol}
#    my $account = get_account($params, "fees/trading/BTC-USD", $loglevel);
#    print Dumper $account;
#
#GET /account/volume
#    my $account = get_account($params, "volume", $loglevel);
#    print Dumper $account;
#
#GET /account/permissions/markets
#    my $account = get_account($params, "permissions/markets", $loglevel);
#    print Dumper $account;
#
#GET /account/permissions/markets/{marketSymbol}
#    my $account = get_account($params, "permissions/markets/BTC-USD", $loglevel);
#    print Dumper $account;
#
#GET /account/permissions/currencies
#    my $account = get_account($params, "permissions/currencies", $loglevel);
#    print Dumper $account;
#
#GET /account/permissions/currencies/{currencySymbol}
#    my $account = get_account($params, "permissions/currencies/BTC", $loglevel);
#    print Dumper $account;
#
#ADDRESSES
#
#GET /addresses
#    my $addresses = get_addresses($params, undef, $loglevel);
#    print Dumper $addresses;
#
#POST /addresses
#    my $newAddress = {currencySymbol => "USDT"};
#    my $addresses = post_addresses($params, $newAddress, $loglevel);
#    print Dumper $addresses;
#
#GET /addresses/{currencySymbol}
#    my $addresses = get_addresses($params, "BTC", $loglevel);
#    print Dumper $addresses;
#
#BALANCES
#
#GET /balances
#    my $balances = get_balances($params, undef, $loglevel);
#    print Dumper $balances;
#
#HEAD /balances
#    my $balances_head = head_balances($params, $loglevel);
#    print Dumper $balances_head;
#
#GET /balances/{currencySymbol}
#    my $balances = get_balances($params, "BTC", $loglevel);
#    print Dumper $balances;
#
#BATCH
#
#    my $newBatch = [
#        {
#            "resource" => "order",
#            "operation" => "post",
#            "payload" => {
#                "marketSymbol" => "BTC-EUR",
#                "direction" => "BUY",
#                "type" => "LIMIT",
#                "quantity" => 1,
#                "limit" => 1,
#                "timeInForce" => "GOOD_TIL_CANCELLED" 
#            }
#        },
#        {
#            "resource" => "order",
#            "operation" => "post",
#            "payload" => {
#                "marketSymbol" => "ETH-EUR",
#                "direction" => "BUY",
#                "type" => "LIMIT",
#                "quantity" => 1,
#                "limit" => 1,
#                "timeInForce" => "GOOD_TIL_CANCELLED" 
#            }
#        }
#    ];
#    my $batch = post_batch($params, $newBatch, $loglevel);
#    print Dumper $batch;
#
#CONDITIONAL ORDERS
#
#GET /conditional-orders/{conditionalOrderId}
#    my $conditionalOrderId = "0";
#    my $orders = get_conditional_orders($params, "$conditionalOrderId", undef,$loglevel);
#    print Dumper $orders;
#
#DELETE /conditional-orders/{conditionalOrderId}
#    my $conditionalOrderId = "";
#    my $orders = del_conditional_orders($params, $conditionalOrderId, $loglevel);
#    print Dumper $orders;
#
#GET /conditional-orders/open
#    my $orders = get_conditional_orders($params, "open", "marketSymbol=BTC-USD", $loglevel);
#    print Dumper $orders;
#
#GET /conditional-orders/closed
#    my $orders = get_conditional_orders($params, "closed", "marketSymbol=USD-BTC", $loglevel);
#    print Dumper $orders;
#
#HEAD /conditional-orders/open
#    my $orders = head_conditional_orders($params, "open", $loglevel);
#    print Dumper $orders;
#
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
#    my $orders = post_conditional_orders($params, $newConditialOrder, $loglevel);
#    print Dumper $orders;
#
#CURRENCIES
#
#GET /currencies
#    my $currencies = get_currencies(undef, $loglevel);
#    print Dumper $currencies;
#
#GET /currencies/{symbol}
#    my $currencies = get_currencies("BTC", $loglevel);
#    print Dumper $currencies;
#
#DEPOSITS
#
#GET /deposits/open
#    my $deposits = get_deposits($params, "open", undef, $loglevel);
#    print Dumper $deposits;
#
#HEAD /deposits/open
#    my $deposits = head_deposits($params, "open", $loglevel);
#    print Dumper $deposits;
#
#GET /deposits/closed
#    my $deposits = get_deposits($params, "closed", undef, $loglevel);
#    print Dumper $deposits;
#
#GET /deposits/ByTxId/{txId}
#    my $txId = "";
#    my $deposits = get_deposits($params, "ByTxId/$txId", undef, $loglevel);
#    print Dumper $deposits;
#
#GET /deposits/{depositId}
#    my $depositId = "";
#    my $deposits = get_deposits($params, "$depositId", undef, $loglevel);
#    print Dumper $deposits;
#
#EXECUTIONS
#
#GET /executions/{executionId}
#    my $executionId = "";
#    my $executions = get_executions($params, $executionId, undef, $loglevel);
#    print Dumper $executions;
#
#GET /executions
#    my $executionQuery = "marketSymbol=BTC-USD";
#    my $executions = get_executions($params, undef, $executionQuery, $loglevel);
#    print Dumper $executions;
#
#GET /executions/last-id
#    my $executions = get_executions($params, "last-id", undef, $loglevel);
#    print Dumper $executions;
#
#HEAD /executions/last-id
#    my $executions = head_executions($params, "last-id", undef, $loglevel);
#    print Dumper $executions;
#
#FUNDS TRANSFER METHODS
#
#GET /funds-transfer-methods/{fundsTransferMethodId}
#    my $fundsTransferMethodId = "";
#    my $methods = get_funds_transfer_methods($params, $fundsTransferMethodId, undef, $loglevel);
#    print Dumper $methods;
#
#MARKETS
#
#GET /markets
#    my $markets = get_markets(undef, undef, undef, $loglevel);
#    print Dumper $markets;
#
#GET /markets/summaries
#    my $markets = get_markets(undef, "summaries", undef, $loglevel);
#    print Dumper $markets;
#
#HEAD /markets/summaries
#    my $markets = head_markets(undef, "summaries", undef, $loglevel);
#    print Dumper $markets;
#
#GET /markets/tickers
#    my $markets = get_markets(undef, "tickers", undef, $loglevel);
#    print Dumper $markets;
#
#HEAD /markets/tickers
#    my $markets = head_markets(undef, "tickers", undef, $loglevel);
#    print Dumper $markets;
#
#GET /markets/{marketSymbol}/ticker
#    my $markets = get_markets("BTC-USD", "ticker", undef, $loglevel);
#    print Dumper $markets;
#
#GET /markets/{marketSymbol}
#    my $markets = get_markets("BTC-USD", undef, undef, $loglevel);
#    print Dumper $markets;
#
#GET /markets/{marketSymbol}/summary
#    my $markets = get_markets("BTC-USD", "summary", undef, $loglevel);
#    print Dumper $markets;
#
#GET /markets/{marketSymbol}/orderbook
#    my $markets = get_markets("BTC-USD", "orderbook", "depth=25", $loglevel); # depth can be only 1, 25, 500
#    print Dumper $markets;
#HEAD /markets/{marketSymbol}/orderbook
#    my $markets = head_markets("BTC-USD", "orderbook", undef, $loglevel); # depth can be only 1, 25, 500
#    print Dumper $markets;
#
#GET /markets/{marketSymbol}/trades
#    my $markets = get_markets("BTC-USD", "trades", undef, $loglevel); # depth can be only 1, 25, 500
#    print Dumper $markets;
#
#HEAD /markets/{marketSymbol}/trade
#    my $markets = head_markets("BTC-USD", "trades", undef, $loglevel); # depth can be only 1, 25, 500
#    print Dumper $markets;
#
#GET /markets/{marketSymbol}/candles
#    my $markets = get_markets("BTC-USD", "candles", "candleInterval=HOUR_1", $loglevel); # MINUTE_1, MINUTE_5, HOUR_1, DAY_1
#    print Dumper $markets;
#
#GET /markets/{marketSymbol}/candles/{candleInterval}/recent
#    my $markets = get_markets("BTC-USD", "candles/HOUR_1/recent", undef, $loglevel); # MINUTE_1, MINUTE_5, HOUR_1, DAY_1
#    print Dumper $markets;
#
#HEAD /markets/{marketSymbol}/candles/{candleInterval}/recent
#    my $markets = head_markets("BTC-USD", "candles/HOUR_1/recent", undef, $loglevel); # MINUTE_1, MINUTE_5, HOUR_1, DAY_1
#    print Dumper $markets;
#
#GET /markets/{marketSymbol}/candles/{candleInterval}/historical/{year}/{month}/{day}
#    my $markets = get_markets("BTC-USD", "candles/HOUR_1/historical/2020/4/12", undef, $loglevel); # MINUTE_1, MINUTE_5, HOUR_1, DAY_1
#    print Dumper $markets;
#
#ORDERS
#
#GET /orders/closed
#    my $orders = get_orders($params, "closed", "marketSymbol=BTC-USD", $loglevel);
#    print Dumper $orders;
#
#GET /orders/open
#    my $orders = get_orders($params, "open", "marketSymbol=BTC-USD", $loglevel);
#    print Dumper $orders;
#
#DELETE /orders/open
#    my $orders = del_orders($params, "open", undef, $loglevel);
#    print Dumper $orders;
#
#HEAD /orders/open
#    my $orders = head_orders($params, "open", undef, $loglevel);
#    print Dumper $orders;
#
#GET /orders/{orderId}
#    my $orderId = "";
#    my $orders = get_orders($params, $orderId, undef, $loglevel);#
#    print Dumper $orders;
#
#DELETE /orders/{orderId}
#    my $orderId = "";
#    my $orders = del_orders($params, $orderId, undef, $loglevel);
#    print Dumper $orders;
#
#GET /orders/{orderId}/executions
#    my $orderId = "";
#    my $orders = get_orders($params, $orderId . "/executions", undef, $loglevel);
#    print Dumper $orders;
#
#POST /orders
#    my $newOrder = {
#        marketSymbol  => "BTC-USD",            #
#        direction     => "BUY",                # BUY, SELL
#        type          => "LIMIT",              # LIMIT, MARKET, CEILING_LIMIT, CEILING_MARKET
#        quantity      => "1.000",              #
#        limit         => "10.000",             #
#        timeInForce   => 'GOOD_TIL_CANCELLED'  #GOOD_TIL_CANCELLED, IMMEDIATE_OR_CANCEL, FILL_OR_KILL, POST_ONLY_GOOD_TIL_CANCELLED, BUY_NOW
#    };
#    my $orders = post_orders($params, $newOrder, $loglevel);
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
#    my $subaccounts = get_subaccounts($params, undef, $query, $loglevel);
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
#    my $subaccounts = post_subaccounts($params, $newSubaccount, $loglevel);
#    print Dumper $subaccounts;
#GET /subaccounts/{subaccountId}
#    my $subaccountId = "string";
#    my $subaccounts = get_subaccounts($params, $subaccountId, undef, $loglevel);
#    print Dumper $subaccounts;
#
#TRANSFERS - NOT A REGULAR FUNCTION! FOR BITTREX PARTNERS ONLY!
#
#GET /transfers/sent
#    my $query = "toSubaccountId='string'&toMasterAccount=boolean&currencySymbol=string&nextPageToken='string'
#                &previousPageToken='string'&pageSize=Int32&startDate='string'&endDate='string'";
#    my $transfers = get_transfers($params, "sent", $query, $loglevel);
#    print Dumper $transfers;
#GET /transfers/received
#    my $query = "toSubaccountId='string'&toMasterAccount=boolean&currencySymbol=string&nextPageToken='string'
#                &previousPageToken='string'&pageSize=Int32&startDate='string'&endDate='string'";
#    my $transfers = get_transfers($params, "received", $query, $loglevel);
#    print Dumper $transfers;
#GET /transfers/{transferId}
#    my $transferId = "";
#    my $transfers = get_transfers($params, $transferId, undef, $loglevel);
#    print Dumper $transfers;
#POST /transfers
#    my $newTransfer = {
#        toSubaccountId => "string (uuid)",
#        requestId => "string (uuid)",
#        currencySymbol => "string",
#        amount => "number (double)",
#        toMasterAccount => "boolean"
#    };
#    my $transfers = post_transfers($params, $newTransfer, $loglevel);
#    print Dumper $transfers;
#
#WITHRDRAWALS
#
#GET /withdrawals/open
#    my $withdrawals = get_withdrawals($params, "open", undef, $loglevel);
#    print Dumper $withdrawals;
#GET /withdrawals/closed
#    my $withdrawals = get_withdrawals($params, "closed", undef, $loglevel);
#    print Dumper $withdrawals;
#GET /withdrawals/ByTxId/{txId}
#    my $txId = "";
#    my $withdrawals = get_withdrawals($params, "ByTxId/$txId", undef, $loglevel);
#    print Dumper $withdrawals;
#GET /withdrawals/{withdrawalId}
#    my $withdrawalId = "";
#    my $withdrawals = get_withdrawals($params, $withdrawalId, undef, $loglevel);
#    print Dumper $withdrawals;
#DELETE /withdrawals/{withdrawalId}
#    my $withdrawalId = "";
#    my $withdrawals = del_withdrawals($params, $withdrawalId, $loglevel);
#    print Dumper $withdrawals;
#POST /withdrawals
#    my $walletid = "";
#    my $newWithdrawal = {
#        currencySymbol   => "XZC",
#        quantity         => "0.4",
#        cryptoAddress    => $walletid
#    };
#    my $withdrawals = post_withdrawals($params, $newWithdrawal, $loglevel);
#    print Dumper $withdrawals;
#GET /withdrawals/whitelistAddresses
#    my $withdrawals = get_withdrawals($params, "whitelistAddresses", undef, $loglevel);
#    print Dumper $withdrawals;
#
###############################################################################################
# Subs
###############################################################################################

sub logmessage {
    my $string = $_[0];
    my $loglevel = $_[1];
    if ($loglevel > 5) { print $string; }
}

