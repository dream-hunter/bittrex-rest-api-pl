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
@EXPORT_OK   = qw(get_bittrex_api );
%EXPORT_TAGS =  ( DEFAULT => [qw(&get_bittrex_api )]);

###############################################################################################
#
# Be careful using the code. Careless use of the subs below can result in a loss of money!
#
# Read additional (official) information here: https://bittrex.github.io/api/v3
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

1;