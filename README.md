# ansible-role
ansible-role



admin1@ansible:~/Desktop/ansible-role$ ansible-playbook -i inventory playbooks/deploy_nginx.yml 

PLAY [Deploy Nginx Server] *******************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************
[WARNING]: Platform linux on host 192.168.145.164 is using the discovered Python interpreter at /usr/bin/python3.10,
but future installation of another Python interpreter could change the meaning of that path. See
https://docs.ansible.com/ansible-core/2.17/reference_appendices/interpreter_discovery.html for more information.
ok: [192.168.145.164]

TASK [linux_web : Cập nhật danh sách package] ************************************************************************
changed: [192.168.145.164]

TASK [linux_web : Cài đặt Nginx] *************************************************************************************
ok: [192.168.145.164]

TASK [linux_web : Đảm bảo Nginx đang chạy] ***************************************************************************
ok: [192.168.145.164]

TASK [linux_web : Cài đặt Git] ***************************************************************************************
ok: [192.168.145.164]

TASK [linux_web : Clone source code từ GitHub] ***********************************************************************
ok: [192.168.145.164]

TASK [linux_web : Restart Nginx] *************************************************************************************
changed: [192.168.145.164]

TASK [linux_web : Sao chép file cấu hình Nginx] **********************************************************************
changed: [192.168.145.164]

TASK [linux_web : Bật site cấu hình mới] *****************************************************************************
ok: [192.168.145.164]

RUNNING HANDLER [linux_web : Restart Nginx] **************************************************************************
changed: [192.168.145.164]

PLAY RECAP ***********************************************************************************************************
192.168.145.164            : ok=10   changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  