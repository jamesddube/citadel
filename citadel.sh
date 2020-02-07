#!/bin/bash

while getopts u:a: option
do
case "${option}"
in
u) SITE=${OPTARG};;
a) ALT=${OPTARG};;
esac   

done


CERTBOT_HOME=$HOME/.certbot

echo " "
echo "------------------------------------------------------------"
echo "Generating Keys :"
echo "------------------------------------------------------------"

openssl genrsa -out $CERTBOT_HOME/certificates/$SITE.key 2048

echo " "
echo "------------------------------------------------------------"
echo "Generating CSR for:"
echo "site: $SITE   alt:$ALT"
echo "------------------------------------------------------------"

cp $CERTBOT_HOME/config/site.conf $CERTBOT_HOME/$SITE.conf
sed -i "s/VALET_DOMAIN/${ALT}/g" $CERTBOT_HOME/$SITE.conf

openssl req -new -key $CERTBOT_HOME/certificates/$SITE.key -out $CERTBOT_HOME/certificates/$SITE.csr -subj "/C=US/ST=MN/O=Valet1/localityName=Valet1/commonName=$SITE/organizationalUnitName=IT/emailAddress=info@$SITE/" -config $CERTBOT_HOME/$SITE.conf -passin pass:

echo " "
echo "------------------------------------------------------------"
echo "Generating Certificate for:"
echo "site: $SITE   alt:$ALT"
echo "------------------------------------------------------------"
echo " "

openssl x509 -req -sha256 -days 365 -in $CERTBOT_HOME/certificates/$SITE.csr -signkey $CERTBOT_HOME/certificates/$SITE.key -out $CERTBOT_HOME/certificates/$SITE.crt -extensions v3_req -extfile $CERTBOT_HOME/$SITE.conf

rm $CERTBOT_HOME/$SITE.conf
