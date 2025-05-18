
## 🧰 Установка пакета **Coreutils**

**Coreutils** содержит основные утилиты GNU, такие как `cat`, `ls`, `cp`, `mv`, `rm`, `chown`, `chmod` и т.д. Эти инструменты необходимы для функционирования любой UNIX-подобной системы.

---

## 🔧 1. Подготовка к компиляции

```bash
cd $DLFS/sources/
tar -xf coreutils-9.5.tar.xz
cd coreutils-9.5
mkdir -v build && cd build
../configure --prefix=/usr \
            --host=$DLFS_TGT \
            --build=$(../build-aux/config.guess) \
            --enable-install-program=hostname \
            --enable-no-install-program=kill,uptime
```

### 📖 Пояснение параметров:

- `--prefix=/usr` — устанавливает программы в директорию `/usr`, а не в `/bin` или `/sbin`.
    
- `--host=$DLFS_TGT` — кросс-компиляция для целевой системы (DLFS).
    
- `--build=$(build-aux/config.guess)` — определяет архитектуру хоста автоматически.
    
- `--enable-install-program=hostname` — включает установку утилиты `hostname`, которая **по умолчанию не устанавливается**, но требуется для тестов некоторых пакетов.
    
- `--enable-no-install-program=kill,uptime` — отключает установку `kill` и `uptime`, которые мы позже получим из пакета **procps-ng**.
    

---

## ⚙️ 2. Компиляция

```bash
bash -c "$MAKE_CMD"
```

---

## 📦 3. Установка во временное окружение

```bash
make DESTDIR=$DLFS install
```

> 💡 `DESTDIR=$DLFS` гарантирует установку пакета во временную файловую систему DLFS, а не на хост.

---

## 🚚 4. Перемещение программ в их **конечные** каталоги

Некоторые утилиты, такие как `chroot`, **ожидаются в других местах** системой и скриптами. Поэтому:

```bash
mv -v $DLFS/usr/bin/chroot $DLFS/usr/sbin
```

### 📁 Переместим man-страницу `chroot` из раздела 1 в 8

```bash
mkdir -pv $DLFS/usr/share/man/man8
mv -v $DLFS/usr/share/man/man1/chroot.1 $DLFS/usr/share/man/man8/chroot.8
sed -i 's/"1"/"8"/' $DLFS/usr/share/man/man8/chroot.8
```

> `chroot` — это **административная утилита**, и man-страницы таких программ должны быть в разделе **8**, а не **1** (user commands).

---

## ✅ После выполнения

- Все основные утилиты GNU установлены во временную систему
    
- `chroot` перенесён в `/usr/sbin`
    
- Документация `chroot` исправлена для корректной классификации
    

---
## Очистка

```bash
rm -rf $DLFS/sources/coreutils-9.5
```
