#!/bin/zsh

echo "Generating certificates for use with CircleCI, press enter to continue"
read check1
openssl genrsa -des3 -passout pass:x -out server.pass.key 2048
openssl rsa -passin pass:x -in server.pass.key -out server.key
rm server.pass.key
echo "We will now generate the server key, when promoted for a password, press enter"
echo "press enter to continue"
read check2
openssl req -new -key server.key -out server.csr
echo "we will now generate the certificates, press enter to continue"
openssl x509 -req -sha256 -days 365 -in server.csr -signkey server.key -out server.crt
echo "the key will now be encoded in BASE64 and displayed, use the output for the value of SFDC_SERVER_KEY enviornment variable"
echo "/n"
base64 server.key
echo "we will now clean up, keys will be deleted"
rm server.csr
rm server.key
echo "certificate and key generateion complete, please add server.crt to your OAuth connected app in salesforce"