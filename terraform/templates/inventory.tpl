[web]
${web_ip} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_ed25519

[app]
${app_ip} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_ed25519

[db]
${db_ip} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_ed25519

[all:vars]
ansible_ssh_common_args=-o StrictHostKeyChecking=no
