#!/bin/bash
# This file should be generated by our ServicePanel, and provisioned with the SSH-keys that the customer has on his Hypernode

set -e

user="app"
homedir=$(getent passwd $user | cut -d ':' -f6)
sudo -u $user mkdir -p "$homedir/.ssh"
sudo -u $user touch "$homedir/.ssh/authorized_keys"
chmod 700 "$homedir/.ssh"
chmod 600 "$homedir/.ssh/authorized_keys"

if ssh-add -L >/dev/null 2>/dev/null; then
    ssh-add -L >> $homedir/.ssh/authorized_keys;
fi

cat << EOF >> $homedir/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDSERHiEjdibIowB763wgGn4OCdko4b8WfqmgihgiIsVIX76RP6oTgAO9uqkNkirYilCT0DF33CGk06h1DkqRZ4mUN3bNNz+tlFBwJnT/sAj4gPe6rt1hK68m55p1SZRrMPbLyFPM0XUWSvVzJd8hSwIOEFgc5Igcj1OvJz2MqlSlRrRgi1ageAlIofoRh6G2JMqRVAQiBKLCvzT0KDEoionkC/kDWckDOLApVKof2dzsiG2WmV2nZrVyvwJPNBAUYiTZ53JrMqy491ojs/PvnPlJpvXgHMTEHIyt3hNKyJIRtDukzZBldayGV1dsj0SPXxWPqnc898rc6PQpL9IKSRDn1uxWKPeQ7WYYTl1uV4E30setuAILazRoS2EXdCD+nKZd9gw0h3YuZYKChjKeNWAdNHR46s6AGJDHTIYmgksrLiTPM/c7joSlpexi+/FrUJF5VOB2X/uul17Es7IWILdlgGnAIHpbLBw71j3gamGU3+ciaCrblB7FZJtxbiG7wXAL0MQIHdF3LOrPrBONVqOXA2VlpEHyerCMkXyc7U5sFosV8mlqPUGocDzGQx6y7tCuCE6KxLyoaDiENYnQOyiTg1cXbQTd7m6Z6kkIEXLT/vHKLxqXW1qCjV8dS4U5Rfx8B2GkCP0sWstR1XWRTNCBUnzfN3NztCBR8PsrZ/yw== vagrant@deploy
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key
EOF

rm -rf /etc/cron.d/hypernode-fpm-monitor
