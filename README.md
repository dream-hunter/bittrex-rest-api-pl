# bittrex-rest-api

This open source project was created to give an understanding of the Bittrex API v1.1/v3.0 in pearl language.
The sample file shows the methods in accordance with the official specification.
Working with a software product implies a basic understanding of the basics of programming in perl and API.

# System prerequisites:

 1. Installed linux OS (ubuntu/centos etc)
 2. Latest Perl with modules:
    - Data::Dumper
    - JSON
    - Digest::SHA
    - REST::Client
    - Time::HiRes
 3. Installed git
 4. Verified Bittrex Account with activated Two-Factor Authentication
 5. Synchronized time on your host computer
 6. Internet access to Bittrex API endpoint https://api.bittrex.com/v3 / https://api.bittrex.com/api/v1.1

# How to use

```
sudo apt update
sudo apt upgrade
sudo apt install perl librest-client-perl libjson-perl libdata-dumper-concise-perl libdigest-sha-perl libtime-hr-perl
git clone https://github.com/dream-hunter/bittrex-rest-api.git
cd bittrex-rest-api
perl APIv3sample.pl
perl APIv11sample.pl
```
# Donations

If you wanna help my project, send your donations to the following wallets:

```
BTC: 17kZJHjouZqLmMwntg2M6zzdEW3Jivx79o
ETH: 0xda1be63336b49e25201d2f406f01b1989f6146c1
```
# Future plans
 1. Tests and fixes a possible bugs
 2. Writing free bot
 3. Improving stability and performance

# Update log
**2020/08/22
 Some minor update for easier use

**2020/08/13**
 Fixed check for json_decode to avoid program termination if it fails.

**2020/06/09**
 All API v3.0 subroutines moved from sample file to BittrexAPIv3.pm

**2020/06/08**
 Added module for REST API v1.1

**2020/06/05**
 Project created