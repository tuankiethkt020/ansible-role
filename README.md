# ansible-role
ansible-role


admin1@ansible:~/Desktop/ansible-role$ ansible-playbook -i inventory --ask-vault-pass --extra-vars '@passwd2.yml' playbooks/deploy_nginx.yml 
Vault password: 

PLAY [Deploy Nginx Server] **************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************
[WARNING]: Platform linux on host 192.168.145.164 is using the discovered Python interpreter at /usr/bin/python3.10, but
future installation of another Python interpreter could change the meaning of that path. See
https://docs.ansible.com/ansible-core/2.17/reference_appendices/interpreter_discovery.html for more information.
ok: [192.168.145.164]

TASK [linux_web : Kiểm tra và xóa thư mục nginx_root nếu tồn tại] ***********************************************************
changed: [192.168.145.164]

TASK [linux_web : Cài đặt Git] **********************************************************************************************
ok: [192.168.145.164]

TASK [linux_web : include_tasks] ********************************************************************************************
included: /home/admin1/Desktop/ansible-role/roles/linux_web/tasks/debug.yml for 192.168.145.164

TASK [linux_web : In thông điệp debug] **************************************************************************************
ok: [192.168.145.164] => 
  msg: 'Kết quả cài đặt Git: {''changed'': False, ''cache_updated'': False, ''cache_update_time'': 1738649667, ''failed'': False}'

TASK [linux_web : Clone source code từ GitHub] ******************************************************************************
changed: [192.168.145.164]

TASK [linux_web : include_tasks] ********************************************************************************************
included: /home/admin1/Desktop/ansible-role/roles/linux_web/tasks/debug.yml for 192.168.145.164

TASK [linux_web : In thông điệp debug] **************************************************************************************
ok: [192.168.145.164] => 
  msg: 'Kết quả clone source code: {''changed'': True, ''before'': None, ''after'': ''3b593fd6f38109e0e9469f33bf720b938c8fff45'', ''failed'': False}'

TASK [linux_web : Thêm quyền ghi cho thư mục uploads] ***********************************************************************
changed: [192.168.145.164]

TASK [linux_web : Xóa database test_db trong MySQL (nếu tồn tại)] ***********************************************************
changed: [192.168.145.164]

TASK [linux_web : Copy file test_db.sql vào MySQL] **************************************************************************
changed: [192.168.145.164]

TASK [linux_web : Import file SQL vào MySQL] ********************************************************************************
changed: [192.168.145.164]

TASK [linux_web : Xóa file SQL sau khi import] ******************************************************************************
changed: [192.168.145.164]

TASK [linux_web : Cập nhật danh sách package] *******************************************************************************
changed: [192.168.145.164]

TASK [linux_web : Cài đặt Nginx, PHP-FPM, PHP-MySQL và MySQL Server] ********************************************************
ok: [192.168.145.164]

TASK [linux_web : Cài đặt pip3] *********************************************************************************************
ok: [192.168.145.164]

TASK [linux_web : Cài đặt PyMySQL (cho Python 3)] ***************************************************************************
ok: [192.168.145.164]

TASK [linux_web : Thu thập thông tin các dịch vụ] ***************************************************************************
ok: [192.168.145.164]

TASK [linux_web : Phát hiện tên service PHP-FPM tự động] ********************************************************************
ok: [192.168.145.164]

TASK [linux_web : Kiểm tra đã tìm thấy PHP-FPM chưa] ************************************************************************
skipping: [192.168.145.164]

TASK [linux_web : In ra tên service PHP-FPM được phát hiện] *****************************************************************
ok: [192.168.145.164] => 
  msg: 'Tên service PHP-FPM được phát hiện là: php8.1-fpm'

TASK [linux_web : Đảm bảo Nginx đang chạy] **********************************************************************************
ok: [192.168.145.164]

TASK [linux_web : Đảm bảo PHP-FPM đang chạy] ********************************************************************************
ok: [192.168.145.164]

TASK [linux_web : Đảm bảo dịch vụ MySQL đang chạy] **************************************************************************
ok: [192.168.145.164]

TASK [linux_web : Restart Nginx] ********************************************************************************************
changed: [192.168.145.164]

TASK [linux_web : Sao chép file cấu hình Nginx từ template] *****************************************************************
ok: [192.168.145.164]

TASK [linux_web : include_tasks] ********************************************************************************************
included: /home/admin1/Desktop/ansible-role/roles/linux_web/tasks/debug.yml for 192.168.145.164

TASK [linux_web : In thông điệp debug] **************************************************************************************
ok: [192.168.145.164] => 
  msg: 'Kết quả sao chép file cấu hình Nginx: {''diff'': {''before'': {''path'': ''/etc/nginx/sites-available/default''}, ''after'': {''path'': ''/etc/nginx/sites-available/default''}}, ''path'': ''/etc/nginx/sites-available/default'', ''changed'': False, ''uid'': 0, ''gid'': 0, ''owner'': ''root'', ''group'': ''root'', ''mode'': ''0644'', ''state'': ''file'', ''size'': 531, ''checksum'': ''17b7fbfbfc598d34ca447915c230fd79ef6c27eb'', ''dest'': ''/etc/nginx/sites-available/default'', ''failed'': False}'

TASK [linux_web : Bật site cấu hình mới (tạo symlink)] **********************************************************************
ok: [192.168.145.164]

TASK [linux_web : include_tasks] ********************************************************************************************
included: /home/admin1/Desktop/ansible-role/roles/linux_web/tasks/debug.yml for 192.168.145.164

TASK [linux_web : In thông điệp debug] **************************************************************************************
ok: [192.168.145.164] => 
  msg: 'Kết quả tạo symlink kích hoạt site: {''dest'': ''/etc/nginx/sites-enabled/default'', ''src'': ''/etc/nginx/sites-available/default'', ''changed'': False, ''diff'': {''before'': {''path'': ''/etc/nginx/sites-enabled/default''}, ''after'': {''path'': ''/etc/nginx/sites-enabled/default''}}, ''uid'': 0, ''gid'': 0, ''owner'': ''root'', ''group'': ''root'', ''mode'': ''0777'', ''state'': ''link'', ''size'': 34, ''failed'': False}'

PLAY RECAP ******************************************************************************************************************
192.168.145.164            : ok=30   changed=9    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0   
