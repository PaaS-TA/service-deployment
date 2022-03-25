#!/bin/bash
mysql_path=/var/vcap/store/mariadb-10.5.15-linux-x86_64/bin/mysql #경로 확인 및 수정
mysql_port='<mysql_port>'           #mariadb port : (e.g. 13306)
mysql_user='<mysql_user>'           #mariadb user : (e.g. root)
mysql_password='<mysql_password>'   #mariadb password 
# insert code table
${mysql_path} -u${mysql_user} -p${mysql_password} -P${mysql_port} -Ddelivery_pipeline  << "EOF"
insert  into `code`(`code_type`,`code_group`,`code_name`,`code_value`,`code_order`) values ('language_type', NULL,'PHP', 'PHP', 2);
insert  into `code`(`code_type`,`code_group`,`code_name`,`code_value`,`code_order`) values ('language_type_version', 'PHP','PHP-7.4', 'PHP-7.4', 2);
insert  into `code`(`code_type`,`code_group`,`code_name`,`code_value`,`code_order`) values ('builder_type', 'PHP','COMPOSER', 'COMPOSER', 2);
insert  into `code`(`code_type`,`code_group`,`code_name`,`code_value`,`code_order`) values ('builder_type_version', 'COMPOSER','COMPOSER-2', 'COMPOSER-2.1.14', 2);
EOF

${mysql_path} -u${mysql_user} -p${mysql_password} -P${mysql_port} -Ddelivery_pipeline -e "select * from code;"

echo 'php data insert complete'