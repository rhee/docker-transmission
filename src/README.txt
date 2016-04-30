

(1)

Couldn't create socket: Too many open files (fdlimit.c:682)

--> fdlimit patch

transmission-2.82-nofdlimit.patch


(2)

buffer overflow:

*** buffer overflow detected ***: /opt/moviehash/bin/transmission-daemon terminated
======= Backtrace: =========
/lib/x86_64-linux-gnu/libc.so.6(__fortify_fail+0x37)[0x7f26cf821f47]
/lib/x86_64-linux-gnu/libc.so.6(+0x109e40)[0x7f26cf820e40]
/lib/x86_64-linux-gnu/libc.so.6(+0x10aefe)[0x7f26cf821efe]
/usr/lib/x86_64-linux-gnu/libcurl.so.4(curl_multi_fdset+0xeb)[0x7f26d031c4ab]
/opt/moviehash/bin/transmission-daemon[0x4203ef]
/opt/moviehash/bin/transmission-daemon[0x407dfa]
/lib/x86_64-linux-gnu/libpthread.so.0(+0x7e9a)[0x7f26cfadee9a]
/lib/x86_64-linux-gnu/libc.so.6(clone+0x6d)[0x7f26cf80b3fd]

--> libcurl rebuild
