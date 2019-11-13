mkdir -p /data/src
cd /data/src
if [ ! -x "LuaJIT-2.0.0.tar.gz" ]; then  
wget http://luajit.org/download/LuaJIT-2.0.0.tar.gz
fi
tar zxvf LuaJIT-2.0.0.tar.gz
cd LuaJIT-2.0.0
make
make install PREFIX=/usr/local/lj2
ln -s /usr/local/lj2/lib/libluajit-5.1.so.2 /lib64/
cd /data/src
if [ ! -x "v0.2.17rc2.zip" ]; then  
wget https://github.com/simpl/ngx_devel_kit/archive/v0.2.17rc2.zip
fi
unzip v0.2.17rc2
if [ ! -x "v0.10.13.tar.gz" ]; then  
wget https://github.com/openresty/lua-nginx-module/archive/v0.10.13.tar.gz
fi
tar zxvf v0.10.13.tar.gz
cd /data/src
if [ ! -x "pcre-8.10.tar.gz" ]; then
wget http://blog.s135.com/soft/linux/nginx_php/pcre/pcre-8.10.tar.gz
fi
tar zxvf pcre-8.10.tar.gz
cd pcre-8.10/
./configure
make && make install
cd ..
if [ ! -x "nginx-1.14.2.tar.gz" ]; then
wget 'http://nginx.org/download/nginx-1.14.2.tar.gz'
fi
tar -xzvf nginx-1.14.2.tar.gz
cd nginx-1.14.2/
export LUAJIT_LIB=/usr/local/lj2/lib/
export LUAJIT_INC=/usr/local/lj2/include/luajit-2.0/
./configure --user=daemon --group=daemon --prefix=/usr/local/nginx/ --with-http_stub_status_module --with-http_sub_module --with-http_gzip_static_module --without-mail_pop3_module --without-mail_imap_module --without-mail_smtp_module  --add-module=../ngx_devel_kit-0.2.17rc2/ --add-module=../lua-nginx-module-0.7.4/
make -j8
make install 
#rm -rf /data/src
cd /usr/local/nginx/conf/
wget https://github.com/loveshell/ngx_lua_waf/archive/master.zip --no-check-certificate
unzip master.zip
mv ngx_lua_waf-master waf
# rm -rf /data/src
mkdir -p /usr/local/nginx/logs/hack/
chmod -R 777 /usr/local/nginx/logs/hack/

