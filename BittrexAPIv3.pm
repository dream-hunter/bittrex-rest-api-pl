package BittrexAPIv3;

use strict;
use Exporter;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);

use JSON        qw(from_json encode_json);
use Digest::SHA qw(hmac_sha512_hex sha512_hex);
use REST::Client;
use Time::HiRes qw(gettimeofday);

use Data::Dumper;

$VERSION     = 1.00;
@ISA         = qw(Exporter);
@EXPORT      = ();
@EXPORT_OK   = qw(
    get_bittrex_api
    get_account
    get_addresses
    post_addresses
    get_balances
    head_balances
    del_conditional_orders
    get_conditional_orders
    post_conditional_orders
    get_currencies
    get_deposits
    head_deposits
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
%EXPORT_TAGS =  ( DEFAULT => [qw(&get_bittrex_api )]);

###############################################################################################
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

sub logmessage {
    my $string = $_[0];
    my $loglevel = $_[1];
    if ($loglevel > 5) { print $string; }
}

sub url_request {
    my $api = $_[0];
    my $uri = $_[1];
    my $parameters = $_[2];
    my $method = $_[3];
    my $loglevel = $_[4];
    my $response_code = 0;
    my $decoded = undef;

    if ($method eq "DELETE") {
        ($response_code, $decoded) = url_request_del($api, $uri, $parameters, $method, $loglevel)
    }
    if ($method eq "GET") {
        ($response_code, $decoded) = url_request_get($api, $uri, $parameters, $method, $loglevel)
    }
    if ($method eq "HEAD") {
        ($response_code, $decoded) = url_request_head($api, $uri, $parameters, $method, $loglevel)
    }
    if ($method eq "POST") {
        ($response_code, $decoded) = url_request_post($api, $uri, $parameters, $method, $loglevel)
    }
    return ($response_code, $decoded);
}

sub url_request_del {
    my $api        = $_[0];
    my $uri        = $_[1];
    my $parameters = $_[2];
    my $method     = $_[3];
    my $loglevel   = $_[4];
    my $apikey     = $api->{apikey};
    my $apisecret  = $api->{apisecret};
    my $nonce      = sprintf('%.0f', gettimeofday()*1000);
    my $rest = REST::Client->new();

    if (defined $parameters) {
        $uri .= "?".$parameters;
    }

    if (defined $apikey && defined $apisecret) {
        my $contentHash = sha512_hex("");
        my $preSign = "$nonce$uri$method$contentHash";
        my $signature = hmac_sha512_hex($preSign, $apisecret);

        $rest->addHeader('Api-Key', $apikey);
        $rest->addHeader('Api-Timestamp', $nonce);
        $rest->addHeader('Api-Content-Hash', $contentHash);
        $rest->addHeader('Api-Signature', $signature);
        $rest->addHeader('Content-Type', 'application/json');
        $rest->addHeader('Accept', 'application/json');

    }
    $rest->DELETE($uri);

    logmessage ("\nurl_request $uri",$loglevel-1);
    my $response_body = $rest->responseContent();
    my $response_code = $rest->responseCode();
    if ($response_code == 200 || $response_code == 201) {
        logmessage ("\nurl_request URL response code: $response_code; ",$loglevel-1);
        my $decoded = from_json($response_body);
        logmessage ("\nurl_request REST message: \"$response_body\". \n",$loglevel-1);
        return ($response_code, $decoded);
    } elsif ($response_code == 404) {
        logmessage ("\nurl_request: An error happened. URL response code: $response_code;\n",$loglevel-1);
        return $response_code, undef;
    } else {
        logmessage ("\nurl_request: An unhandeled error happened. URL response code: $response_code;\n$response_body\n",$loglevel-1);
        return $response_code, undef;
    }
}

sub url_request_get {
    my $api        = $_[0];
    my $uri        = $_[1];
    my $parameters = $_[2];
    my $method     = $_[3];
    my $loglevel   = $_[4];
    my $apikey     = $api->{apikey};
    my $apisecret  = $api->{apisecret};
    my $nonce      = sprintf('%.0f', gettimeofday()*1000);
    my $rest = REST::Client->new();

    if (defined $parameters) {
        $uri .= "?".$parameters;
    }

    if (defined $apikey && defined $apisecret) {
        my $contentHash = sha512_hex("");
        my $preSign = "$nonce$uri$method$contentHash";
        my $signature = hmac_sha512_hex($preSign, $apisecret);

        $rest->addHeader('Api-Key', $apikey);
        $rest->addHeader('Api-Timestamp', $nonce);
        $rest->addHeader('Api-Content-Hash', $contentHash);
        $rest->addHeader('Api-Signature', $signature);
        $rest->addHeader('Content-Type', 'application/json');
        $rest->addHeader('Accept', 'application/json');

    }
    $rest->GET($uri);

    logmessage ("\nurl_request $uri",$loglevel-1);
    my $response_body = $rest->responseContent();
    my $response_code = $rest->responseCode();
    if ($response_code == 200 || $response_code == 201) {
        logmessage ("\nurl_request URL response code: $response_code; ",$loglevel-1);
        my $decoded = from_json($response_body);
        logmessage ("\nurl_request REST message: \"$response_body\". \n",$loglevel-1);
        return ($response_code, $decoded);
    } elsif ($response_code == 404) {
        logmessage ("\nurl_request: An error happened. URL response code: $response_code;\n",$loglevel-1);
        return $response_code, undef;
    } else {
        logmessage ("\nurl_request: An unhandeled error happened. URL response code: $response_code;\n$response_body\n",$loglevel-1);
        return $response_code, undef;
    }
}

sub url_request_head {
    my $api        = $_[0];
    my $uri        = $_[1];
    my $parameters = $_[2];
    my $method     = $_[3];
    my $loglevel   = $_[4];
    my $apikey     = $api->{apikey};
    my $apisecret  = $api->{apisecret};
    my $nonce      = sprintf('%.0f', gettimeofday()*1000);
    my $rest = REST::Client->new();

    if (defined $parameters) {
        $uri .= "?".$parameters;
    }

    if (defined $apikey && defined $apisecret) {
        my $contentHash = sha512_hex("");
        my $preSign = "$nonce$uri$method$contentHash";
        my $signature = hmac_sha512_hex($preSign, $apisecret);

        $rest->addHeader('Api-Key', $apikey);
        $rest->addHeader('Api-Timestamp', $nonce);
        $rest->addHeader('Api-Content-Hash', $contentHash);
        $rest->addHeader('Api-Signature', $signature);
        $rest->addHeader('Content-Type', 'application/json');
        $rest->addHeader('Accept', 'application/json');

    }
    $rest->HEAD($uri);

    logmessage ("\nurl_request $uri",$loglevel-1);
    my $response_code = $rest->responseCode();
    return $response_code, $rest;
}

sub url_request_post {
    my $api        = $_[0];
    my $uri        = $_[1];
    my $parameters = $_[2];
    my $method     = $_[3];
    my $loglevel   = $_[4];
    my $apikey     = $api->{apikey};
    my $apisecret  = $api->{apisecret};
    my $nonce      = sprintf('%.0f', gettimeofday()*1000);
    my $rest = REST::Client->new();
    my $params = $rest->buildQuery($parameters);

    if (defined $apikey && defined $apisecret) {
        my $contentHash = sha512_hex(encode_json($parameters));
        my $preSign = "$nonce$uri$method$contentHash";
        my $signature = hmac_sha512_hex($preSign, $apisecret);

        $rest->addHeader('Api-Key', $apikey);
        $rest->addHeader('Api-Timestamp', $nonce);
        $rest->addHeader('Api-Content-Hash', $contentHash);
        $rest->addHeader('Api-Signature', $signature);
        $rest->addHeader('Content-Type', 'application/json');
        $rest->addHeader('Accept', 'application/json');

    }
    $rest->POST($uri, encode_json($parameters));

    logmessage ("\nurl_request $uri",$loglevel-1);
    my $response_body = $rest->responseContent();
    my $response_code = $rest->responseCode();
    my $response_headers = $rest->responseHeaders();
    if ($response_code == 200 || $response_code == 201) {
        logmessage ("\nurl_request URL response code: $response_code; ",$loglevel-1);
        my $decoded = from_json($response_body);
        logmessage ("\nurl_request REST message: \"$response_body\". \n",$loglevel-1);
        return ($response_code, $decoded);
    } elsif ($response_code == 404) {
        logmessage ("\nurl_request: An error happened. URL response code: $response_code;\n",$loglevel-1);
        return $response_code, undef;
    } else {
        logmessage ("\nurl_request: An unhandeled error happened. URL response code: $response_code;\n$response_body\n",$loglevel-1);
        return $response_code, undef;
    }
}

sub get_bittrex_api {
    my $command    = $_[0];
    my $parameters = $_[1];
    my $api        = $_[2];
    my $method     = $_[3];
    my $loglevel   = $_[4];
    logmessage ("\nget_bittrex_api Exec request \"$command\"...\n", $loglevel);
    my $url='https://api.bittrex.com/v3/'.$command;
    my ($response_code, $decoded) = url_request($api, $url, $parameters, $method, $loglevel);
    logmessage ("\nget_bittrex_api Response code: $response_code",$loglevel);
    if ($response_code == 200 || $response_code == 201) {
        logmessage (" - ok\n",$loglevel);
        return ($decoded);
    } else {
        logmessage (" - bad\n",$loglevel);
        return undef;
    }
}

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

1;