 
На этом этапе вы уже собрали полноценную временную систему **DLFS** 
Обычно для продолжения сборки используется `chroot` — это классический, но ручной подход.  
Мы же пойдём более совремённым путём и воспользуемся **Docker**, так как он предоставляет:

- 🧩 автоматическую изоляцию
- 🛠️ гибкость в настройке окружения
- ⚡ кэширование слоёв
- 🤖 удобную автоматизацию через Dockerfile
- 📦 лёгкое распространение образов

> В этом разделе мы рассмотрим, **как Docker изолирует среду на лету** и чем он выгодно отличается от `chroot`.

---

## 🧱 Docker и chroot: Сравнение возможностей

| Возможность                                  | `chroot`  | `Docker` |
| -------------------------------------------- | --------- | -------- |
| 🔁 Изоляция процессов (`PID namespace`)      | ❌ Нет     | ✅ Да     |
| 🌐 Изоляция сети (`NET namespace`)           | ❌ Нет     | ✅ Да     |
| 📂 Изоляция монтирования (`Mount namespace`) | ❌ Нет     | ✅ Да     |
| 🧷 Поддержка OverlayFS                       | ❌ Нет     | ✅ Да     |
| ⚙️ Автомонтирование `/proc`, `/sys`          | ❌ Вручную | ✅ Авто   |
| 🖥️ Установка hostname                       | ❌ Вручную | ✅ Авто   |
| 📄 Настройка `/etc/hosts`, `resolv.conf`     | ❌ Нет     | ✅ Да     |

---

## 🧬 Как Docker изолирует среду

### 🗂️ 1. OverlayFS

Docker использует **слоистую файловую систему**:

- `lowerdir` — базовая система
- `upperdir` — изменения пользователя
- `workdir` — рабочая область

💡 Это обеспечивает:

- 🔐 Защиту оригинального rootfs
- ✏️ Возможность правок без модификации оригинала

---

### 📂 2. Виртуальные файловые системы

Docker сам монтирует:

```text
/proc → proc  
/sys → sysfs  
/dev → tmpfs  
/dev/pts → devpts  
/dev/shm → tmpfs  
/run → tmpfs
```

❗ В `chroot` это делается вручную:

```text
mount -t proc      proc     $DLFS/proc
mount -t sysfs     sysfs    $DLFS/sys
mount -t devtmpfs  devtmpfs $DLFS/dev
```


---

Исторически сложилось, что Linux хранит список примонтированных файловых систем в файле /etc/ mtab . Современные ядра хранят этот список внутри себя и предоставляют его пользователю через файловую систему /proc . Чтобы удовлетворять требованиям утилит, которые ожидают наличия /etc/mtab, в Docker автоматически создается симлинк

```text
bash-5.2# ls -al /etc/mtab
lrwxrwxrwx 1 0 0 12 May 18 20:20 /etc/mtab -> /proc/mounts
bash-5.2# 
```

❗ В `chroot` это делается вручную:

```text
ln -sv /proc/self/mounts /etc/mtab
```


---

### 🧾 3. DNS и имя хоста

Docker автоматически создаёт:

- `/etc/hostname`
     
- `/etc/hosts`
    
- `/etc/resolv.conf`
    

❗ В `chroot` это делается вручную:

/etc/hostname 
```text
bash-5.2# cat /etc/hostname 
dlfs
```

/etc/hosts
```text
bash-5.2# cat /etc/hosts
127.0.0.1	localhost
::1	localhost ip6-localhost ip6-loopback
fe00::0	ip6-localnet
ff00::0	ip6-mcastprefix
ff02::1	ip6-allnodes
ff02::2	ip6-allrouters
```

/etc/resolv.conf 
```text
bash-5.2# cat /etc/resolv.conf 
nameserver 8.8.8.8
nameserver 8.8.4.4
```

---

### 🌍 4. Переменные среды

Docker сам задаёт переменные:

```text
HOSTNAME=dlfs
TERM=xterm
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
```

❗ В `chroot` это делается вручную:

/etc/environment
```text
HOSTNAME=dlfs
TERM=xterm
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
```

---

## ✅ Вывод

Использование **Docker** вместо `chroot`:

- 🔐 Обеспечивает лучшую изоляцию
    
- ⚙️ Автоматизирует процессы
    
- 🧹 Избавляет от ручной настройки

