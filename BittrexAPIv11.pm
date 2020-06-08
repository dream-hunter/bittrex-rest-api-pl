package BittrexAPIv11;

use strict;
use Exporter;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);

use JSON        qw(from_json);
use Digest::SHA qw(hmac_sha512_hex);
use REST::Client;

$VERSION     = 1.00;
@ISA         = qw(Exporter);
@EXPORT      = ();
@EXPORT_OK   = qw(get_bittrex_api );
%EXPORT_TAGS =  ( DEFAULT => [qw(&get_bittrex_api )]);

sub logmessage {
    my $string = $_[0];
    my $loglevel = $_[1];
    if ($loglevel > 5) { print $string; }
}

sub url_request {
    my $api = $_[0];
    my $uri = $_[1];
    my $parameters = $_[2];
    my $loglevel = $_[3];
    my $rest = REST::Client->new();
    my $response_body;
    my $apikey = $api->{apikey};
    my $apisecret = $api->{apisecret};
    my $nonce = time();

    if (defined $apikey && defined $apisecret) {
        $uri .= "?apikey=".$apikey."&nonce=".$nonce;
        if (defined $parameters) {
            $uri .= "&".$parameters;
        }
        logmessage ("\n$uri",$loglevel);
        my $sign = hmac_sha512_hex($uri,$apisecret);
        $rest->addHeader('apisign', $sign);
    } else {
        if (defined $parameters) {
            $uri .= "?".$parameters;
        }
        logmessage ("\n$uri", $loglevel);
    }

    $rest->GET($uri);

    my $response_body = $rest->responseContent();
    my $response_code = $rest->responseCode();
    if ($response_code == 200) {
        logmessage ("\nurl_request URL response code: $response_code; ",5);
        my $decoded = from_json($response_body);
        logmessage ("API success: $decoded->{success}; API message: \"$decoded->{message}\". \n",5);
        return ($response_code, $decoded);
    } elsif ($response_code == 404) {
        logmessage ("\nAn error happened. URL response code: $response_code;\n",5);
        return $response_code, '', undef;
    } else {
        logmessage ("\nAn unhandeled error happened. Return code: $response_code\n",5);
        return $response_code, '', undef;
    }
}

sub get_bittrex_api {
    my $path       = $_[0];
    my $query      = $_[1];
    my $api        = $_[2];
    my $loglevel   = $_[3];
    logmessage ("\nget_bittrex_api Exec request \"$path\"...\n", $loglevel);
    my $url='https://api.bittrex.com/api/v1.1/'.$path;
    my ($response_code, $decoded) = url_request($api, $url, $query, $loglevel-1);
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