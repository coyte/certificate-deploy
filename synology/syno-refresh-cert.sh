#!/usr/bin/env bash
set -e
# Purpose: Update Server certificates
# find certificates that might need an update
# cd /usr && find . -name "*.pem"


declare -a CERT_DIRS=(
  "/usr/local/etc/certificate/WebStation/vhost_5dd5a8fe-5989-4791-b97a-0d231fd491c7/"
  "/usr/local/etc/certificate/ActiveBackup/ActiveBackup/"
  "/usr/syno/etc/certificate/smbftpd/ftpd/"
  "/usr/syno/etc/certificate/system/default/"
)


for d in "${CERT_DIRS[@]}"; do
# echo "$d"
  cp /volume1/dockerdata/dnsrobocert/letsencrypt/live/nas.teekens.info/cert.pem "$d"
  cp /volume1/dockerdata/dnsrobocert/letsencrypt/live/nas.teekens.info/chain.pem "$d"
  cp /volume1/dockerdata/dnsrobocert/letsencrypt/live/nas.teekens.info/fullchain.pem "$d"
  cp /volume1/dockerdata/dnsrobocert/letsencrypt/live/nas.teekens.info/privkey.pem "$d"
done


# synoservicecfg --list
set +e
synoservicectl --reload pkgctl-WebStation
synoservicectl --reload pkgctl-ActiveBackup
synoservicectl --reload pkgctl-Apache2.4
synoservicectl --restart nginx


#echo "Done"