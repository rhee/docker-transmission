#!/bin/sh

sh configure --prefix=/opt/transmission --enable-static \
&& make \
&& make install

# Optional Features:
#   --disable-option-checking  ignore unrecognized --enable/--with options
#   --disable-FEATURE       do not include FEATURE (same as --enable-FEATURE=no)
#   --enable-FEATURE[=ARG]  include FEATURE [ARG=yes]
#   --disable-dependency-tracking  speeds up one-time build
#   --enable-dependency-tracking   do not reject slow dependency extractors
#   --enable-gcc-warnings   enable verbose warnings with GCC
#   --disable-thread-support
#                           disable support for threading
#   --disable-malloc-replacement
#                           disable support for replacing the memory mgt
#                           functions
#   --disable-openssl       disable support for openssl encryption
#   --disable-debug-mode    disable support for running in debug mode
#   --disable-libevent-install, disable installation of libevent
# 
#   --disable-libevent-regress, skip regress in make check
# 
#   --enable-function-sections, make static library allow smaller binaries with --gc-sections
# 
#   --enable-shared[=PKGS]  build shared libraries [default=yes]
#   --enable-static[=PKGS]  build static libraries [default=yes]
#   --enable-fast-install[=PKGS]
#                           optimize for fast installation [default=yes]
#   --disable-libtool-lock  avoid locking (might break parallel builds)
# 
# Optional Packages:
#   --with-PACKAGE[=ARG]    use PACKAGE [ARG=yes]
#   --without-PACKAGE       do not use PACKAGE (same as --with-PACKAGE=no)
#   --with-pic[=PKGS]       try to use only PIC/non-PIC objects [default=use
#                           both]
#   --with-gnu-ld           assume the C compiler uses GNU ld [default=no]
#   --with-sysroot=DIR Search for dependent libraries within DIR
#                         (or the compiler's sysroot if not specified).
# 
# Some influential environment variables:
#   CC          C compiler command
#   CFLAGS      C compiler flags
#   LDFLAGS     linker flags, e.g. -L<lib dir> if you have libraries in a
#               nonstandard directory <lib dir>
#   LIBS        libraries to pass to the linker, e.g. -l<library>
#   CPPFLAGS    (Objective) C/C++ preprocessor flags, e.g. -I<include dir> if
#               you have headers in a nonstandard directory <include dir>
#   CPP         C preprocessor

