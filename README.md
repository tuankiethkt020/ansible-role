# ansible-role
ansible-role
admin1@ansible:~/Desktop/ansible-role$ ansible-playbook -i inventory --ask-vault-pass --extra-vars '@passwd2.yml' playbooks/deploy_nginx.yml 

ansible-playbook -i inventory --ask-vault-pass --extra-vars "@windows_web_vault.yml" playbooks/deploy_windows.yml
