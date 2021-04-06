PREREQ:
Install IDRAC admin on Ubuntu:
apt install -y gpg libssl-dev

gpg --keyserver pool.sks-keyservers.net --recv-key 1285491434D8786F
gpg -a --export 1285491434D8786F | sudo apt-key add -
echo 'deb http://linux.dell.com/repo/community/openmanage/932/bionic bionic main' | sudo tee -a /etc/apt/sources.list.d/linux.dell.com.sources.list
apt-get update
apt-get install srvadmin-idracadm8

UPDATE CERTS:
racadm -r idrac-1.nilab.io -u root -p <password> sslkeyupload -f privkey.pem -t 1
racadm -r idrac-1.nilab.io -u root -p <password> sslcertupload -f fullchain.pem -t 1
racadm -r idrac-1.nilab.io -u root -p <password> racreset soft -f




