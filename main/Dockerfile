# Используем официальный образ AlmaLinux 9
FROM almalinux:9

# Устанавливаем необходимые утилиты и плагины dnf
RUN dnf update -y && \
    dnf install -y 'dnf-command(config-manager)' && \
    dnf config-manager --set-enabled crb && \
    dnf install -y \
    gcc \
    meson \
    ninja-build \
    systemd-devel \
    git \
    libmount-devel \
    libcap-devel \
    libblkid-devel \
    libacl-devel \
    libgcrypt-devel \
    gperf \
    python3-docutils \
    pkgconf-pkg-config \
    xz-devel \
    zlib-devel \
    libseccomp-devel \
    libselinux-devel \
    dbus-devel \
    kmod-devel \
    pam-devel \
    python3-jinja2

# Устанавливаем базовые утилиты и инструменты разработки
RUN dnf update -y && \
    dnf groupinstall -y "Development Tools" && \
    dnf install -y \
    # Основные компиляторы и библиотеки
    gcc \
    gcc-c++ \
    gcc-gfortran \
    cmake \
    clang \
    llvm \
    # Системные утилиты и сборка
    make \
    cmake \
    cmake3 \
    ninja-build \
    autoconf \
    automake \
    libtool \
    # Заголовочные файлы и стандартные библиотеки
    glibc-devel \
    libstdc++-devel \
    kernel-headers \
    # Работа с исходниками и пакетами
    git \
    wget \
    #curl \
    tar \
    rpm-build \
    pkg-config \
    # Отладка и анализ
    gdb \
    strace \
    ltrace \
    valgrind \
    # Доп. библиотеки (часто требуются)
    zlib-devel \
    openssl-devel \
    ncurses-devel \
    readline-devel \
    bzip2-devel \
    sqlite-devel \
    libffi-devel \
    # Графика / GUI (опционально)
    libX11-devel \
    libXext-devel \
    libXrender-devel \
    mesa-libGL-devel \
    # Сетевые и мультимедийные библиотеки
    boost-devel \
    libcurl-devel \
    libxml2-devel \
    gmp-devel \ 
    mpfr-devel \
    libmpc-devel \
    perl-open \
    perl-FindBin \
    gmp-devel \
    mpfr-devel \
    libmpc-devel \
    glibc-devel.i686 \ 
    libgcc.i686 \
    # Очистка кеша для уменьшения размера
    && dnf clean all \
    && rm -rf /var/cache/dnf

RUN dnf install -y texinfo bison &&\
dnf remove -y byacc &&\
ln -sf /usr/bin/bison /usr/bin/yacc


RUN mkdir -p /tmp/build

#• Acl (2.3.2) - 363 KB:
#Домашняя страница: https://savannah.nongnu.org/projects/acl
RUN curl -L https://download.savannah.gnu.org/releases/acl/acl-2.3.2.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 590765dee95907dbc3c856f7255bd669

#• Attr (2.5.2) - 484 KB:
#Домашняя страница: https://savannah.nongnu.org/projects/attr
RUN curl -L https://download.savannah.gnu.org/releases/attr/attr-2.5.2.tar.gz --output-dir /tmp/build -O
#Контрольная сумма MD5: 227043ec2f6ca03c0948df5517f9c927

#• Autoconf (2.72) - 1,360 KB:
#Домашняя страница: https://www.gnu.org/software/autoconf/
RUN curl -L https://ftp.gnu.org/gnu/autoconf/autoconf-2.72.tar.xz --output-dir /tmp/build -O
#Контрольная сумма MD5: 1be79f7106ab6767f18391c5e22be701

#• Automake (1.17) - 1,614 KB:
#Домашняя страница: https://www.gnu.org/software/automake/
RUN curl -L https://ftp.gnu.org/gnu/automake/automake-1.17.tar.xz --output-dir /tmp/build -O
#Контрольная сумма MD5: 7ab3a02318fee6f5bd42adfc369abf10

#• Bash (5.2.32) - 10,697 KB:
#Домашняя страница: https://www.gnu.org/software/bash/
RUN curl -L https://ftp.gnu.org/gnu/bash/bash-5.2.32.tar.gz --output-dir /tmp/build -O
#Контрольная сумма MD5: f204835b2e06c06e37b5ad776ff907f4

#• Bc (6.7.6) - 463 KB:
#Домашняя страница: https://git.gavinhoward.com/gavin/bc
RUN curl -L https://github.com/gavinhoward/bc/releases/download/6.7.6/bc-6.7.6.tar.xz --output-dir /tmp/build -O
#Контрольная сумма MD5: a47aa5e4e7395fbcd159a9228613b97b                                                                                 

#• Bison (3.8.2) - 2,752 KB:
#Домашняя страница: https://www.gnu.org/software/bison/
RUN curl -L https://ftp.gnu.org/gnu/bison/bison-3.8.2.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: c28f119f405a2304ff0a7ccdcc629713

#• Check (0.15.2) - 760 KB:
#Домашняя страница: https://libcheck.github.io/check
RUN curl -L https://github.com/libcheck/check/releases/download/0.15.2/check-0.15.2.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 50fcafcecde5a380415b12e9c574e0b2

#• Coreutils (9.5) - 5,867 KB:
#Домашняя страница: https://www.gnu.org/software/coreutils/
RUN curl -L https://ftp.gnu.org/gnu/coreutils/coreutils-9.5.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: e99adfa059a63db3503cc71f3d151e31

#• DejaGNU (1.6.3) - 608 KB:
#Домашняя страница: https://www.gnu.org/software/dejagnu/
RUN curl -L https://ftp.gnu.org/gnu/dejagnu/dejagnu-1.6.3.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 68c5208c58236eba447d7d6d1326b821

#• Diffutils (3.10) - 1,587 KB:
#Домашняя страница: https://www.gnu.org/software/diffutils/
RUN curl -L https://ftp.gnu.org/gnu/diffutils/diffutils-3.10.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 2745c50f6f4e395e7b7d52f902d075bf

#• E2fsprogs (1.47.1) - 9,720 KB:
#Домашняя страница: https://e2fsprogs.sourceforge.net/
RUN curl -L https://downloads.sourceforge.net/project/e2fsprogs/e2fsprogs/v1.47.1/e2fsprogs-1.47.1.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 75e6d1353cbe6d5728a98fb0267206cb

#• Expat (2.6.2) - 474 KB:
#Домашняя страница: https://libexpat.github.io/
RUN curl -L https://prdownloads.sourceforge.net/expat/expat-2.6.2.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 0cb75c8feb842c0794ba89666b762a2d

#• Expect (5.45.4) - 618 KB:
#Домашняя страница: https://core.tcl.tk/expect/
RUN curl -L https://prdownloads.sourceforge.net/expect/expect5.45.4.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 00fce8de158422f5ccd2666512329bd2                                                                                  

#• File (5.45) - 1,218 KB:
#Домашняя страница: https://www.darwinsys.com/file/
RUN curl -L https://astron.com/pub/file/file-5.45.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 26b2a96d4e3a8938827a1e572afd527a

#• Findutils (4.10.0) - 2,189 KB:
#Домашняя страница: https://www.gnu.org/software/findutils/
RUN curl -L https://ftp.gnu.org/gnu/findutils/findutils-4.10.0.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 870cfd71c07d37ebe56f9f4aaf4ad872

#• Flex (2.6.4) - 1,386 KB:
#Домашняя страница: https://github.com/westes/flex
RUN curl -L https://github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 2882e3179748cc9f9c23ec593d6adc8d

#• Flit-core (3.9.0) - 41 KB:
#Домашняя страница: https://pypi.org/project/flit-core/
RUN curl -L https://pypi.org/packages/source/f/flit-core/flit_core-3.9.0.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 3bc52f1952b9a78361114147da63c35b

#• Gawk (5.3.0) - 3,356 KB:
#Домашняя страница: https://www.gnu.org/software/gawk/
RUN curl -L https://ftp.gnu.org/gnu/gawk/gawk-5.3.0.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 97c5a7d83f91a7e1b2035ebbe6ac7abd

#• GCC (14.2.0) - 90,144 KB:
#Домашняя страница: https://gcc.gnu.org/
RUN curl -L https://ftp.gnu.org/gnu/gcc/gcc-14.2.0/gcc-14.2.0.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 2268420ba02dc01821960e274711bde0

#• GDBM (1.24) - 1,168 KB:
#Домашняя страница: https://www.gnu.org/software/gdbm/
RUN curl -L https://ftp.gnu.org/gnu/gdbm/gdbm-1.24.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: c780815649e52317be48331c1773e987

#• Gettext (0.22.5) - 10,031 KB:
#Домашняя страница: https://www.gnu.org/software/gettext/
RUN curl -L https://ftp.gnu.org/gnu/gettext/gettext-0.22.5.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 3ae5580599d84be93e6213930facb2db

#• Glibc (2.40) - 18,313 KB:
#Домашняя страница: https://www.gnu.org/software/libc/
RUN curl -L https://ftp.gnu.org/gnu/glibc/glibc-2.40.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: b390feef233022114950317f10c4fa97                                                                                      

#• GMP (6.3.0) - 2,046 KB:
#Домашняя страница: https://www.gnu.org/software/gmp/
RUN curl -L https://ftp.gnu.org/gnu/gmp/gmp-6.3.0.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 956dc04e864001a9c22429f761f2c283

#• Gperf (3.1) - 1,188 KB:
#Домашняя страница: https://www.gnu.org/software/gperf/
RUN curl -L https://ftp.gnu.org/gnu/gperf/gperf-3.1.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 9e251c0a618ad0824b51117d5d9db87e

#• Grep (3.11) - 1,664 KB:
#Домашняя страница: https://www.gnu.org/software/grep/
RUN curl -L https://ftp.gnu.org/gnu/grep/grep-3.11.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 7c9bbd74492131245f7cdb291fa142c0

#• Groff (1.23.0) - 7,259 KB:
#Домашняя страница: https://www.gnu.org/software/groff/
RUN curl -L https://ftp.gnu.org/gnu/groff/groff-1.23.0.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 5e4f40315a22bb8a158748e7d5094c7d

#• GRUB (2.12) - 6,524 KB:
#Домашняя страница: https://www.gnu.org/software/grub/
RUN curl -L https://ftp.gnu.org/gnu/grub/grub-2.12.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 60c564b1bdc39d8e43b3aab4bc0fb140

#• Gzip (1.13) - 819 KB:
#Домашняя страница: https://www.gnu.org/software/gzip/
RUN curl -L https://ftp.gnu.org/gnu/gzip/gzip-1.13.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: d5c9fc9441288817a4a0be2da0249e29

#• Iana-Etc (20240806) - 590 KB:
#Домашняя страница: https://www.iana.org/protocols
RUN curl -L https://github.com/Mic92/iana-etc/releases/download/20240806/iana-etc-20240806.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: ea3c37c00d22f1159fc3b7d988de8476

#• Inetutils (2.5) - 1,632 KB:
#Домашняя страница: https://www.gnu.org/software/inetutils/
RUN curl -L https://ftp.gnu.org/gnu/inetutils/inetutils-2.5.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 9e5a6dfd2d794dc056a770e8ad4a9263

#• Intltool (0.51.0) - 159 KB:
#Домашняя страница: https://freedesktop.org/wiki/Software/intltool
RUN curl -L https://launchpad.net/intltool/trunk/0.51.0/+download/intltool-0.51.0.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 12e517cac2b57a0121cda351570f1e63

#• IPRoute2 (6.10.0) - 900 KB:
#Домашняя страница: https://www.kernel.org/pub/linux/utils/net/iproute2/
RUN curl -L https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-6.10.0.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 6282e47de9c5b230e83537fba7181c9c

#• Jinja2 (3.1.4) - 235 KB:
#Домашняя страница: https://jinja.palletsprojects.com/en/3.1.x/
RUN curl -L https://pypi.org/packages/source/J/Jinja2/jinja2-3.1.4.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 02ca9a6364c92e83d14b037bef4732bc                                                                                      

#• Kbd (2.6.4) - 1,470 KB:
#Домашняя страница: https://kbd-project.org/
RUN curl -L https://www.kernel.org/pub/linux/utils/kbd/kbd-2.6.4.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: e2fd7adccf6b1e98eb1ae8d5a1ce5762

#• Kmod (33) - 503 KB:
#Домашняя страница: https://github.com/kmod-project/kmod
RUN curl -L https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-33.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: c451c4aa61521adbe8af147f498046f8

#• Less (661) - 634 KB:
#Домашняя страница: https://www.greenwoodsoftware.com/less/
RUN curl -L https://www.greenwoodsoftware.com/less/less-661.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 44f54b6313c5d71fa1ac224d8d84766a

#• LFS-Bootscripts (20240717) - 34 KB:
RUN curl -L https://mirror.linuxfromscratch.ru/lfs/downloads/12.2-rc1/lfs-bootscripts-20240717.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 7457668a250522e7e1aac27313445ed0

#• Libcap (2.70) - 187 KB:
#Домашняя страница: https://sites.google.com/site/fullycapable/
RUN curl -L https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-2.70.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: df0e20c6eeca849347b87d5d6a8870c0

#• Libffi (3.4.6) - 1,360 KB:
#Домашняя страница: https://sourceware.org/libffi/
RUN curl -L https://github.com/libffi/libffi/releases/download/v3.4.6/libffi-3.4.6.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: b9cac6c5997dca2b3787a59ede34e0eb

#• Libpipeline (1.5.7) - 956 KB:
#Домашняя страница: https://libpipeline.nongnu.org/
RUN curl -L https://download.savannah.gnu.org/releases/libpipeline/libpipeline-1.5.7.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 1a48b5771b9f6c790fb4efdb1ac71342

#• Libtool (2.4.7) - 996 KB:
#Домашняя страница: https://www.gnu.org/software/libtool/
RUN curl -L https://ftp.gnu.org/gnu/libtool/libtool-2.4.7.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 2fc0b6ddcd66a89ed6e45db28fa44232

#• Libxcrypt (4.4.36) - 610 KB:
#Домашняя страница: https://github.com/besser82/libxcrypt/
RUN curl -L https://github.com/besser82/libxcrypt/releases/download/v4.4.36/libxcrypt-4.4.36.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: b84cd4104e08c975063ec6c4d0372446

#• Linux (6.10.5) - 141,739 KB:
#Домашняя страница: https://www.kernel.org/
RUN curl -L https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.10.5.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 276ef1f11ed3713ec5d6f506ff55ac12                                                                                    

#• Lz4 (1.10.0) - 379 KB:
#Домашняя страница: https://lz4.org/
RUN curl -L https://github.com/lz4/lz4/releases/download/v1.10.0/lz4-1.10.0.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: dead9f5f1966d9ae56e1e32761e4e675

#• M4 (1.4.19) - 1,617 KB:
#Домашняя страница: https://www.gnu.org/software/m4/
RUN curl -L https://ftp.gnu.org/gnu/m4/m4-1.4.19.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 0d90823e1426f1da2fd872df0311298d

#• Make (4.4.1) - 2,300 KB:
#Домашняя страница: https://www.gnu.org/software/make/
RUN curl -L https://ftp.gnu.org/gnu/make/make-4.4.1.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: c8469a3713cbbe04d955d4ae4be23eeb

#• Man-DB (2.12.1) - 1,994 KB:
#Домашняя страница: https://www.nongnu.org/man-db/
RUN curl -L https://download.savannah.gnu.org/releases/man-db/man-db-2.12.1.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 7b044e5020aab89db41ac7ee59d6d84a

#• Man-pages (6.9.1) - 1,821 KB:
#Домашняя страница: https://www.kernel.org/doc/man-pages/
RUN curl -L https://www.kernel.org/pub/linux/docs/man-pages/man-pages-6.9.1.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 4d56775b6cce4edf1e496249e7c01c1a

#• MarkupSafe (2.1.5) - 19 KB:
#Домашняя страница: https://palletsprojects.com/p/markupsafe/
RUN curl -L https://pypi.org/packages/source/M/MarkupSafe/MarkupSafe-2.1.5.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 8fe7227653f2fb9b1ffe7f9f2058998a

#• Meson (1.5.1) - 2,205 KB:
#Домашняя страница: https://mesonbuild.com
RUN curl -L https://github.com/mesonbuild/meson/releases/download/1.5.1/meson-1.5.1.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: c4f2b3e5ea632685f61ba1b833c4905c

#• MPC (1.3.1) - 756 KB:
#Домашняя страница: https://www.multiprecision.org/
RUN curl -L https://ftp.gnu.org/gnu/mpc/mpc-1.3.1.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 5c9bc658c9fd0f940e8e3e0f09530c62

#• MPFR (4.2.1) - 1,459 KB:
#Домашняя страница: https://www.mpfr.org/
RUN curl -L https://ftp.gnu.org/gnu/mpfr/mpfr-4.2.1.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 523c50c6318dde6f9dc523bc0244690a

#• Ncurses (6.5) - 2,156 KB:
#Домашняя страница: https://www.gnu.org/software/ncurses/
RUN curl -L https://invisible-mirror.net/archives/ncurses/ncurses-6.5.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: ac2d2629296f04c8537ca706b6977687

#• Ninja (1.12.1) - 235 KB:
#Домашняя страница: https://ninja-build.org/
RUN curl -L https://github.com/ninja-build/ninja/archive/v1.12.1/ninja-1.12.1.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 6288992b05e593a391599692e2f7e490                                                                                

#• OpenSSL (3.3.1) - 17,633 KB:
#Домашняя страница: https://www.openssl.org/
RUN curl -L https://www.openssl.org/source/openssl-3.3.1.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 8a4342b399c18f870ca6186299195984

#• Patch (2.7.6) - 766 KB:
#Домашняя страница: https://savannah.gnu.org/projects/patch/
RUN curl -L https://ftp.gnu.org/gnu/patch/patch-2.7.6.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 78ad9937e4caadcba1526ef1853730d5

#• Perl (5.40.0) - 13,481 KB:
#Домашняя страница: https://www.perl.org/
RUN curl -L https://www.cpan.org/src/5.0/perl-5.40.0.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: cfe14ef0709b9687f9c514042e8e1e82

#• Pkgconf (2.3.0) - 309 KB:
#Домашняя страница: https://github.com/pkgconf/pkgconf
RUN curl -L https://distfiles.ariadne.space/pkgconf/pkgconf-2.3.0.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 833363e77b5bed0131c7bc4cc6f7747b

#• Procps (4.0.4) - 1,369 KB:
#Домашняя страница: https://gitlab.com/procps-ng/procps/
RUN curl -L https://sourceforge.net/projects/procps-ng/files/Production/procps-ng-4.0.4.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 2f747fc7df8ccf402d03e375c565cf96

#• Psmisc (23.7) - 423 KB:
#Домашняя страница: https://gitlab.com/psmisc/psmisc
RUN curl -L https://sourceforge.net/projects/psmisc/files/psmisc/psmisc-23.7.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 53eae841735189a896d614cba440eb10

#• Python (3.12.5) - 19,944 KB:
#Домашняя страница: https://www.python.org/
RUN curl -L https://www.python.org/ftp/python/3.12.5/Python-3.12.5.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 02c7d269e077f4034963bba6befdc715

#• Python Documentation (3.12.5) - 8,188 KB:
RUN curl -L https://www.python.org/ftp/python/doc/3.12.5/python-3.12.5-docs-html.tar.bz2  --output-dir /tmp/build -O
#Контрольная сумма MD5: 52274d813236ca4a972fb6988480dc56

#• Readline (8.2.13) - 2,974 KB:
#Домашняя страница: https://tiswww.case.edu/php/chet/readline/rltop.html
RUN curl -L https://ftp.gnu.org/gnu/readline/readline-8.2.13.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 05080bf3801e6874bb115cd6700b708f

#• Sed (4.9) - 1,365 KB:
#Домашняя страница: https://www.gnu.org/software/sed/
RUN curl -L https://ftp.gnu.org/gnu/sed/sed-4.9.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 6aac9b2dbafcd5b7a67a8a9bcb8036c3

#• Setuptools (72.2.0) - 2,363 KB:
#Домашняя страница: https://pypi.org/project/setuptools/
RUN curl -L https://pypi.org/packages/source/s/setuptools/setuptools-72.2.0.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 2e0ffd0f6fc632a11442b79d9b1c68bd                                                                                   

#• Shadow (4.16.0) - 2,154 KB:
#Домашняя страница: https://github.com/shadow-maint/shadow/
RUN curl -L https://github.com/shadow-maint/shadow/releases/download/4.16.0/shadow-4.16.0.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: eb70bad3316d08f0d3bb3d4bbeccb3b4

#• Sysklogd (2.6.1) - 452 KB:
#Домашняя страница: https://www.infodrom.org/projects/sysklogd/
RUN curl -L https://github.com/troglobit/sysklogd/releases/download/v2.6.1/sysklogd-2.6.1.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: dcf0836a0fcc6568efaad230850d9c86

#• Systemd (256.4) - 15,291 KB:
#Домашняя страница: https://www.freedesktop.org/wiki/Software/systemd/
RUN curl -L https://github.com/systemd/systemd/archive/v256.4/systemd-256.4.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 03bd1ff158ec0bc55428c77a8f8495bd

#• Systemd Man Pages (256.4) - 676 KB:
#Домашняя страница: https://www.freedesktop.org/wiki/Software/systemd/
RUN curl -L https://anduin.linuxfromscratch.org/LFS/systemd-man-pages-256.4.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 8dbcf0ff0d8e5e9d3565f9d2fc153310                                                                                     

#• SysVinit (3.10) - 235 KB:
#Домашняя страница: https://savannah.nongnu.org/projects/sysvinit
RUN curl -L https://github.com/slicer69/sysvinit/releases/download/3.10/sysvinit-3.10.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: b8fbe11062cf16d3b6a3709b7f6978d2

#• Tar (1.35) - 2,263 KB:
#Домашняя страница: https://www.gnu.org/software/tar/
RUN curl -L https://ftp.gnu.org/gnu/tar/tar-1.35.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: a2d8042658cfd8ea939e6d911eaf4152

#• Tcl (8.6.14) - 11,355 KB:
#Домашняя страница: https://tcl.sourceforge.net/
RUN curl -L https://downloads.sourceforge.net/tcl/tcl8.6.14-src.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: c30b57c6051be28fa928d09aca82841e

#• Tcl Documentation (8.6.14) - 1,167 KB:
RUN curl -L https://downloads.sourceforge.net/tcl/tcl8.6.14-html.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 5467198f8d57c54835bf80b98ffb0170

#• Texinfo (7.1) - 5,416 KB:
#Домашняя страница: https://www.gnu.org/software/texinfo/
RUN curl -L https://ftp.gnu.org/gnu/texinfo/texinfo-7.1.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: edd9928b4a3f82674bcc3551616eef3b

#• Time Zone Data (2024a) - 444 KB:
#Домашняя страница: https://www.iana.org/time-zones
RUN curl -L https://www.iana.org/time-zones/repository/releases/tzdata2024a.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 2349edd8335245525cc082f2755d5bf4

#• Udev-lfs Tarball (udev-lfs-20230818) - 10 KB:
RUN curl -L https://anduin.linuxfromscratch.org/LFS/udev-lfs-20230818.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: acd4360d8a5c3ef320b9db88d275dae6                                                                                              

#• Util-linux (2.40.2) - 8,648 KB:
#Домашняя страница: https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/
RUN curl -L https://www.kernel.org/pub/linux/utils/util-linux/v2.40/util-linux-2.40.2.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 88faefc8fefced097e58142077a3d14e

#• Vim (9.1.0660) - 17,629 KB:
#Домашняя страница: https://www.vim.org
RUN curl -L https://github.com/vim/vim/archive/v9.1.0660/vim-9.1.0660.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: c512a99b3704f193be1a181cc644b2b2                                                                                           

#• Wheel (0.44.0) - 99 KB:
#Домашняя страница: https://pypi.org/project/wheel/
RUN curl -L https://pypi.org/packages/source/w/wheel/wheel-0.44.0.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 440ff4fe51579b7ed16f02af8f8d9494

#• XML::Parser (2.47) - 276 KB:
#Домашняя страница: https://github.com/chorny/XML-Parser
RUN curl -L https://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-2.47.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 89a8e82cfd2ad948b349c0a69c494463

#• Xz Utils (5.6.2) - 1,277 KB:
#Домашняя страница: https://tukaani.org/xz
RUN curl -L https://github.com//tukaani-project/xz/releases/download/v5.6.2/xz-5.6.2.tar.xz  --output-dir /tmp/build -O
#Контрольная сумма MD5: bbf73fb28425cebb854328599f85c4cf

#• Zlib (1.3.1) - 1,478 KB:
#Домашняя страница: https://zlib.net/
RUN curl -L https://zlib.net/fossils/zlib-1.3.1.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 9855b6d802d7fe5b7bd5b196a2271655

#• Zstd (1.5.6) - 2,351 KB:
#Домашняя страница: https://facebook.github.io/zstd/
RUN curl -L https://github.com/facebook/zstd/releases/download/v1.5.6/zstd-1.5.6.tar.gz  --output-dir /tmp/build -O
#Контрольная сумма MD5: 5a473726b3445d0e5d6296afd1ab6854                                                                              


# Необходимые патчи
# В дополнение к пакетам требуется несколько патчей. Эти патчи исправляют ошибки в пакетах, которые
# должны быть исправлены сопровождающими. Патчи также вносят небольшие изменения, облегчающие
# работу с пакетами. Для сборки системы LFS потребуются следующие патчи:

#• Bzip2 Documentation Patch - 1.6 KB:
RUN curl -L https://mirror.linuxfromscratch.ru/patches/lfs/12.2-rc1/bzip2-1.0.8-install_docs-1.patch  --output-dir /tmp/build -O
##Контрольная сумма MD5: 6a5ac7e89b791aae556de0f745916f7f

#• Coreutils Internationalization Fixes Patch - 164 KB:
RUN curl -L https://mirror.linuxfromscratch.ru/patches/lfs/12.2-rc1/coreutils-9.5-i18n-2.patch  --output-dir /tmp/build -O
#Контрольная сумма MD5: 58961caf5bbdb02462591fa506c73b6d                                                                                               

#• Expect GCC14 Patch - 7.8 KB:
RUN curl -L https://mirror.linuxfromscratch.ru/patches/lfs/12.2-rc1/expect-5.45.4-gcc14-1.patch  --output-dir /tmp/build -O
#MD5 sum: 0b8b5ac411d011263ad40b0664c669f0

#• Glibc FHS Patch - 2.8 KB:
RUN curl -L https://mirror.linuxfromscratch.ru/patches/lfs/12.2-rc1/glibc-2.40-fhs-1.patch  --output-dir /tmp/build -O
#Контрольная сумма MD5: 9a5997c3452909b1769918c759eff8a2

#• Kbd Backspace/Delete Fix Patch - 12 KB:
RUN curl -L https://mirror.linuxfromscratch.ru/patches/lfs/12.2-rc1/kbd-2.6.4-backspace-1.patch  --output-dir /tmp/build -O
#Контрольная сумма MD5: f75cca16a38da6caa7d52151f7136895

#• SysVinit Consolidated Patch - 2.5 KB:
RUN curl -L https://mirror.linuxfromscratch.ru/patches/lfs/12.2-rc1/sysvinit-3.10-consolidated-1.patch  --output-dir /tmp/build -O
#Контрольная сумма MD5: 17ffccbb8e18c39e8cedc32046f3a475

#• Binutils (2.43.1) - 27,514 KB:
#Домашняя страница: https://www.gnu.org/software/binutils/
RUN curl -L https://ftp.gnu.org/gnu/binutils/binutils-2.43.1.tar.gz --output-dir /tmp/build -O

#• Bzip2 (1.0.8) - 792 KB:
RUN cd /tmp/build && wget https://www.sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz
#Контрольная сумма MD5: 67e051268d0c475ea773822f7500d0e5

#• Elfutils (0.191) - 9,092 KB:
#Домашняя страница: https://sourceware.org/elfutils/
RUN cd /tmp/build &&  wget https://sourceware.org/ftp/elfutils/0.191/elfutils-0.191.tar.bz2
#Контрольная сумма MD5: 636547248fb3fae58ec48030298d3ef7

# Устанавливаем переменные среды
ENV DLFS_TGT="x86_64-dlfs-linux-gnu"
ENV PATH="/mnt/dlfs/tools/bin:${PATH}"
ENV MAKE_CMD="taskset -c 12,13,14,15,16,17,18,19,20,21,22,23 make -j12"
ENV DLFS=/mnt/dlfs

CMD ["/bin/bash"]

