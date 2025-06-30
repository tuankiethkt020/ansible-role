
ansible-playbook -i inventory --ask-vault-pass --extra-vars "@windows_web_vault.yml" playbooks/deploy_windows.yml
