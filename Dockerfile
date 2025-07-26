# 使用官方PHP镜像
FROM php:7.4-fpm

# 安装必要软件
RUN apt-get update && \
    apt-get install -y nginx unzip && \
    docker-php-ext-install pdo_mysql

# 下载并解压Typecho
RUN curl -L https://github.com/typecho/typecho/releases/download/v1.2.1/typecho.zip -o typecho.zip \
    && unzip typecho.zip \
    && rm typecho.zip \
    && mv build/* /var/www/html \
    && chown -R www-data:www-data /var/www/html

# 复制Nginx配置
COPY nginx.conf /etc/nginx/sites-available/default

# 暴露端口
EXPOSE 80

# 启动命令
CMD service php7.4-fpm start && nginx -g "daemon off;"
