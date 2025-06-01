#!/usr/bin/env bash
# Автоматически сгенерированный скрипт из Markdown-файлов в doc/2) Доработка образа DLFS/1 Настройка системы DLFS/

# ==== Из файла: 1) Использование Docker вместо chroot 🚀.md ====

# ==== Из файла: 2) Создание структуры каталогов  📂.md ====
mkdir -pv /{boot,home,mnt,opt,srv}
mkdir -pv /etc/{opt,sysconfig}
mkdir -pv /lib/firmware
mkdir -pv /media/{floppy,cdrom}
mkdir -pv /usr/{,local/}{include,src}
mkdir -pv /usr/lib/locale
mkdir -pv /usr/local/{bin,lib,sbin}
mkdir -pv /usr/{,local/}share/{color,dict,doc,info,locale,man}
mkdir -pv /usr/{,local/}share/{misc,terminfo,zoneinfo}
mkdir -pv /usr/{,local/}share/man/man{1..8}
mkdir -pv /var/{cache,local,log,mail,opt,spool}
mkdir -pv /var/lib/{color,misc,locate}
ln -sfv /run /var/run
ln -sfv /run/lock /var/lock
install -dv -m 0750 /root
install -dv -m 1777 /tmp /var/tmp

# ==== Из файла: 3) Локали в Linux 🌍.md ====
localedef -i C -f UTF-8 C.UTF-8
export LANG=C.UTF-8
echo "Привет, мир"

# ==== Из файла: 4) Базовая настройка пользователей и групп 👥.md ====
cat > /etc/passwd << "EOF"
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/bin:/usr/sbin/nologin
daemon:x:2:2:daemon:/sbin:/usr/sbin/nologin
lp:x:4:7:lp:/var/spool/lpd:/usr/sbin/nologin
mail:x:8:12:mail:/var/spool/mail:/usr/sbin/nologin
games:x:12:100:games:/usr/games:/usr/sbin/nologin
ftp:x:14:50:FTP User:/srv/ftp:/usr/sbin/nologin
nobody:x:65534:65534:Unprivileged:/nonexistent:/usr/sbin/nologin
dbus:x:81:81:System message bus:/run/dbus:/usr/sbin/nologin
systemd-coredump:x:999:997:systemd Core Dumper:/:/usr/sbin/nologin
systemd-oom:x:995:995:systemd OOM Killer:/:/usr/sbin/nologin
tss:x:59:59:TPM access account:/dev/null:/usr/sbin/nologin
sssd:x:994:994:SSSD Daemon:/:/usr/sbin/nologin
EOF
cat > /etc/shadow << "EOF"
root:*:19816:0:99999:7:::
bin:*:19816:0:99999:7:::
daemon:*:19816:0:99999:7:::
lp:*:19816:0:99999:7:::
mail:*:19816:0:99999:7:::
games:*:19816:0:99999:7:::
ftp:*:19816:0:99999:7:::
nobody:*:19816:0:99999:7:::
dbus:!!:20189::::::
systemd-coredump:!!:20189::::::
systemd-oom:!!:20189::::::
tss:!!:20189::::::
sssd:!!:20211::::::
EOF
cat > /etc/group << "EOF"
root:x:0:
bin:x:1:
daemon:x:2:
lp:x:7:
mail:x:12:
games:x:100:
ftp:x:50:
users:x:1000:
nobody:x:65534:
dbus:x:81:
systemd-coredump:x:997:
systemd-oom:x:995:
tss:x:59:
sssd:x:994:
wheel:x:10:
sudo:x:27:
utmp:x:22:
EOF
cat > /etc/gshadow << "EOF"
root:::
bin:::
daemon:::
lp:::
mail:::
games:::
ftp:::
users:::
nobody:::
dbus:!::
systemd-coredump:!::
systemd-oom:!::
tss:!::
sssd:!::
wheel:::
sudo:::
EOF

# ==== Из файла: 5) Настройка логов 🧾.md ====
touch /var/log/{btmp,lastlog,faillog,wtmp}
# Группа utmp — владелец lastlog (обычно GID 22)
chgrp -v utmp /var/log/lastlog

# Доступ к последнему входу: только чтение/запись пользователю и группе
chmod -v 664 /var/log/lastlog

# Журнал неудачных входов — закрыт для чтения
chmod -v 600 /var/log/btmp

# ==== Из файла: 6) Настройка профиля окружения ⚙️.md ====
cat > /etc/profile << "EOF"
#!/bin/sh
# Глобальный профиль для login-shell

# Пути
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# Маска прав по умолчанию
umask 022

# Локаль
export LANG=C.UTF-8

# Подключаем все .sh-модули
if [ -d /etc/profile.d ]; then
  for i in /etc/profile.d/*.sh; do
    [ -r "$i" ] && . "$i"
  done
  unset i
fi
EOF
cat > /etc/bash.bashrc << "EOF"
# Глобальный bashrc для всех пользователей (интерактивный режим)

# Цвета от dircolors
if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b)"
fi

# Безопасные алиасы
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Цветной вывод ls и grep
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# prompt
if [ "$(id -u)" -eq 0 ]; then
    PS1='\[\e[1;31m\]\u@\h:\w# \[\e[0m\]'
else
    PS1='\[\e[1;32m\]\u@\h:\w$ \[\e[0m\]'
fi
EOF
mkdir /etc/skel
cat > /etc/skel/.bash_profile << "EOF"
# Загружаем .bashrc, если есть
[ -f ~/.bashrc ] && . ~/.bashrc

# Пользовательские bin
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi
EOF
cat > /etc/skel/.bashrc << "EOF"
# Подключаем глобальный bashrc
[ -f /etc/bash.bashrc ] && . /etc/bash.bashrc

# Неинтерактивный shell — выходим
case $- in
    *i*) ;;
    *) return ;;
esac

# Доп. алиасы
alias ll='ls -alF'

# История
HISTTIMEFORMAT="%d.%m.%Y %H:%M:%S "
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend
EOF
cat > /etc/skel/.bash_logout << "EOF"
clear
EOF
mkdir /etc/profile.d
cat > /etc/profile.d/colorls.sh << "EOF"
# Цвета для ls через LS_COLORS
if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b)"
fi
EOF
cat > /root/.bashrc << "EOF"
# Безопасность
umask 027
export TMOUT=600

# Цветной prompt
export PS1='\u@\h:\w\$ '

# Алиасы для управления питанием
alias reboot='systemctl reboot'
alias poweroff='systemctl poweroff'

# Удобные алиасы
alias ll='ls -lh --color=auto'
alias la='ls -lah --color=auto'
alias grep='grep --color=auto'
EOF
export USER=root
export HOME=/root
cp -a /etc/skel/. /root/
chown -R root:root /root
export MAKE_CMD="taskset -c 12,13,14,15,16,17,18,19,20,21,22,23 make -j12"
# or
#export MAKE_CMD="make -j$(nproc)"
#export MAKE_CMD="make"
exec bash --login

