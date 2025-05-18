
## 📌 Кратко: что делает эта глава

Ты собираешь `glibc`, используя **кросс-компилятор**, и устанавливаешь её **внутрь DLFS ($DLFS)** — не в хост-систему.  
Эта библиотека позже станет основой твоей новой системы.

## ✅ Что ты должен сделать, шаг за шагом

### 🔹 1. Создать нужные симлинки (для совместимости)

```bash
arch=$(uname -m)
if [[ $arch == i?86 ]]; then
    ln -sfv ld-linux.so.2 "$DLFS/lib/ld-lsb.so.3"
elif [[ $arch == x86_64 ]]; then
    ln -sfv ../lib/ld-linux-x86-64.so.2 "$DLFS/lib64"
    ln -sfv ../lib/ld-linux-x86-64.so.2 "$DLFS/lib64/ld-lsb-x86-64.so.3"
fi
```


### 🔹2. Применить патч FHS
### 🔹 2.1. Перейди в каталог с исходниками:

```bash
cd $DLFS/sources
```

---

### 🔹 2.2. Распакуй glibc:

```bash
tar -xf glibc-2.40.tar.xz
```

---

### 🔹 2.3. Перейди в распакованный каталог:

```bash
cd glibc-2.40
```

---

### 🔹 2.4. Убедись, что патч рядом (в `../`)

```bash
ls ../glibc-2.40-fhs-1.patch
```

---

### 🔹 2.5. Применить патч:

```bash
patch -Np1 -i ../glibc-2.40-fhs-1.patch
```

Пример:
```bash
[root@1ab6670ccfbd glibc-2.40]# patch -Np1 -i ../glibc-2.40-fhs-1.patch
patching file Makeconfig
Hunk #1 succeeded at 262 (offset 12 lines).
patching file nscd/nscd.h
Hunk #1 succeeded at 160 (offset 48 lines).
patching file nss/db-Makefile
Hunk #1 succeeded at 21 (offset -1 lines).
patching file sysdeps/generic/paths.h
patching file sysdeps/unix/sysv/linux/paths.h
[root@1ab6670ccfbd glibc-2.40]# 

```

### 🔹 3. Создать каталог сборки
```bash
mkdir -v build
cd build
```
Сборка glibc **требует отдельной директории**. Нельзя собирать её в корне исходников!


### 🔹 4. Направить установку `ldconfig` и `sln` в /usr/sbin
```bash
echo "rootsbindir=/usr/sbin" > configparms

```
`configparms` — это **локальный файл конфигурации**, который читается только если он находится **в каталоге, где ты запускаешь `../configure`**. Он нужен для того, чтобы glibc установила `ldconfig` и `sln` в `/usr/sbin`

### 🔹 5. Запустить `configure`
```bash
../configure \
  --prefix=/usr \
  --host=$DLFS_TGT \
  --build=$(../scripts/config.guess) \
  --enable-kernel=4.19 \
  --with-headers=$DLFS/usr/include \
  --disable-nscd \
  --without-selinux \
  libc_cv_slibdir=/usr/lib

```

#### 🔍 Пояснение параметров:

#### `--prefix=/usr`

📍 Указывает, **куда будет установлена `glibc`** в файловой системе LFS.

- Всё будет установлено в ==`$DLFS/usr`== (т.к. мы будем использовать  ==`make DESTDIR=$DLFS install`==)
    
- Это основное место для системных библиотек и утилит (по FHS)

---

#### `--host=$LFS_TGT`

🎯 Указывает, **для какой платформы** собирается glibc (например: `x86_64-dlfs-linux-gnu`).

- Это значит, что мы **кросс-компилируем**
    
- `$DLFS_TGT` задаётся заранее, если еще не задана:

 ```
   export DLFS_TGT=$(uname -m)-dlfs-linux-gnu
   ```


---

### `--build=$(../scripts/config.guess)`

###### 🔍 Что делает `../scripts/config.guess`
Это **bash-скрипт**, который возвращает **текущую платформу сборки** в виде "системной триады" (triplet), например:

```
[root@1ab6670ccfbd build]# ../scripts/config.guess
x86_64-pc-linux-gnu
```

---

### `--enable-kernel=4.19`

🧠 Указывает минимальную версию ядра Linux, с которой будет совместима `glibc`.

- Всё, что специфично для ядер **старше 4.19**, будет включено
    
- Всё, что старше 4.19 — **не поддерживается** (оптимизация и упрощение кода)
    

---

### `--with-headers=$LFS/usr/include`

📁 Указывает, **где находятся заголовки ядра Linux**, установленные на шаге `make headers`.

- Это даёт `glibc` информацию о доступных системных вызовах (syscalls) и структурах
    

---

### `--disable-nscd`

❌ Отключает сборку **демона кеширования имен `nscd`**, который устарел и больше не используется.

- Экономит время и место
    
- Не нужен в минимальной системе
    

---

### `libc_cv_slibdir=/usr/lib`

📂 Указывает, **где должна располагаться `glibc.so` и другие важные библиотеки**.

- По умолчанию на x86_64 она ставится в `/lib64`, но мы хотим всё в `/usr/lib`
    
- Это нужно, чтобы не плодить `/lib64`, `/usr/lib64` и прочие дубликаты
    

---

#### 🧩 В итоге

Эта команда:

- компилирует `glibc` **для будущей DLFS-системы**
    
- использует **кросс-компилятор**
    
- ставит всё **внутрь `$DLFS`**
    
- **соблюдает FHS**
    
- **оптимизирована под ядро 4.19+**
    


### 🔹 6. Собери glibc
```bash
bash -c "$MAKE_CMD"
```

### 🔹 7. Установи во временное окружение
```bash
make DESTDIR=$DLFS install
```

❗ ВНИМАНИЕ: не пропускай `DESTDIR=$DLFS`, иначе ты установишь glibc в свою **реальную систему** и всё сломаешь.

#### 🔹 8. Почини `ldd`, чтобы он не ссылался на `/usr/lib/ld-linux...`

```bash
sed '/RTLDLIST=/s@/usr@@g' -i $DLFS/usr/bin/ldd
```

🔧 **"чинит" скрипт  `ldd`**, который был установлен вместе с `glibc`.

---

## 🔍 Что делает команда

- 🔎 Ищет строку, в которой есть `RTLDLIST=...`
    
- ✂️ Удаляет оттуда **упоминание каталога `/usr`**
    
- 📌 Файл редактируется **прямо на месте** (`-i`)
    

---

## ❓ Зачем это нужно

После установки `glibc` файл `$LFS/usr/bin/ldd` может содержать строку:

```
RTLDLIST="/lib/ld-linux.so.2 /usr/lib/ld-linux.so.2"
```

Или:

```
RTLDLIST="/lib64/ld-linux-x86-64.so.2 /usr/lib64/ld-linux-x86-64.so.2"
```

🚫 Но во **временной системе DLFS** нет `ld-linux` в `/usr/...` — они в `/lib`, `/lib64`.

Если не убрать `/usr`, то `ldd` в DLFS будет работать **неправильно** — пытаться найти динамический загрузчик по несуществующему пути.

### 🔹 9. Проверяем, работает ли компилятор с glibc

```bash
echo 'int main(){}' | $DLFS/tools/bin/$DLFS_TGT-gcc -xc -
```

```bash
readelf -l a.out | grep ld-linux
```

Пример:
```bash
[root@1ab6670ccfbd build]#echo 'int main(){}' | $DLFS/tools/bin/$DLFS_TGT-gcc -xc -
[root@1ab6670ccfbd build]# 
[root@1ab6670ccfbd build]# readelf -l a.out | grep ld-linux
      [Requesting program interpreter: /lib64/ld-linux-x86-64.so.2]
[root@1ab6670ccfbd build]# 


```

## Очистка

```bash
rm -rf $DLFS/sources/glibc-2.40
```
