#!/bin/bash
#
# This script creates a 'mini CA' that can be used to create self-signed certs. 
#
# The certs will be 'recognised' on your device if you import and trust the myCA.pem certificate
#
#

exittext=$(cat <<SETVAR

------------------------------------------------------------------------------------------------------

Done!

To use this on an iOS device, do the following:
1. Email the root certificate to yourself so you can access it on your iOS device

2. Click on the attachment in the email on your iOS device

3. Go to the settings app and click ‘Profile Downloaded’ near the top

4. Click install in the top right

5. Once installed, hit close and go back to the main Settings page

6. Go to “General” > “About”

7. Scroll to the bottom and click on “Certificate Trust Settings”

8. Enable your root certificate under “ENABLE FULL TRUST FOR ROOT CERTIFICATES”

SETVAR
)

echo "Generating myCA private key..."
openssl genrsa -des3 -out myCA.key 2048

echo "Generating myCA root certificate..."
openssl req -x509 -new -nodes -key myCA.key -sha256 -days 1825 -out myCA.pem

echo "Adding the Root Certificate to macOS Keychain..."
sudo security add-trusted-cert -d -r trustRoot -k "/Library/Keychains/System.keychain" myCA.pem

echo "$exittext"

