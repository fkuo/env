#!/bin/bash

#First bootstrap for passwordless ssh:
#echo "Bootstrapping for passwordless ssh.  You may have to type your\
# password more than once."
 ssh global "mkdir ~/.ssh"
 scp ~/.ssh/id_rsa.pub global:~/.ssh/authorized_keys

 echo "#!/bin/bash

 if [[ -z \${NTP_SERVER} ]]; then
     NTP_SERVER=\$(grep \"server \" /etc/inet/ntp.conf  | head -1 | cut -d ' ' -f2)
     fi

     svcadm disable ntp
     ntpdate \${NTP_SERVER} && svcadm enable ntp

     exit 0" >/tmp/fix_ntp.sh
     scp /tmp/fix_ntp.sh global:~
     ssh global "chmod +x ~/fix_ntp.sh && ~/fix_ntp.sh"
