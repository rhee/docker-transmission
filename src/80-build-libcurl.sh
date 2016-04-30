:
sh configure \
  --prefix=/opt/transmission \
  --enable-static \
  --without-librtmp \
  --with-ldap-lib=/opt/transmission/lib/libldap.a \
  --with-libidn=/opt/transmission/lib/libidn.a \
&& make \
&& make install
