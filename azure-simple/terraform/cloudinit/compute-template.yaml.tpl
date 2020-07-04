#cloud-config

mounts:
 - [ "//eistorageshare.file.core.windows.net/eishare", /mnt/sharedfs, "cifs", "vers=3.0,username=eistorageshare,password=${storage_access_key},dir_mode=0777,file_mode=0777,serverino", "0", "0"]

runcmd:
 - sed -i 's|CONNECTION_STRING|${db_connection_strings}|g' /tmp/ansible-ei/dev/group_vars/all.yml
 - cd /tmp/ansible-ei &&  ansible-playbook -i dev/inventory site.yml
