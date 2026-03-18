#!/bin/bash

# Оновлення списків пакетів та встановлення Apache
apt-get update
apt-get install -y apache2

# Створення кастомної директорії (DocumentRoot)
mkdir -p /var/www/site_13

# Створення тестової сторінки (щоб було видно, що сервер працює)
echo "<h1>Hello from Terraform! Variant 13. Volodymyr Maselko OI-45</h1>" > /var/www/site_13/index.html

# Надання прав доступу системному користувачу Apache (www-data)
chown -R www-data:www-data /var/www/site_13
chmod -R 755 /var/www/site_13

# Зміна дефолтного порту Apache з 80 на 8000
sed -i 's/Listen 80/Listen 8000/' /etc/apache2/ports.conf

# Створення конфігураційного файлу віртуального хосту для порту 8000
cat <<EOF > /etc/apache2/sites-available/var13.conf
<VirtualHost *:8000>
    ServerName var13.local
    DocumentRoot /var/www/site_13

    # Цей блок вирішує проблему помилки '403 Forbidden'
    <Directory /var/www/site_13>
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/var13_error.log
    CustomLog \${APACHE_LOG_DIR}/var13_access.log combined
</VirtualHost>
EOF

# Вимкнення стандартного сайту та увімкнення нашого
a2dissite 000-default.conf
a2ensite var13.conf

# Перезавантаження Apache для застосування всіх налаштувань
systemctl restart apache2