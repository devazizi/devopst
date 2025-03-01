FROM docker.arvancloud.ir/openresty/openresty:latest

COPY ./nginx.conf /usr/local/openresty/nginx/conf
COPY ./lua_modules/prometheus.lua /usr/local/openresty/lualib/
COPY ./lua_modules/prometheus_resty_counter.lua /usr/local/openresty/lualib/
COPY ./lua_modules/prometheus_keys.lua /usr/local/openresty/lualib/
COPY ./mime.types /etc/nginx/mime.types
