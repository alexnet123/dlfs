`Ncurses` предоставляет интерфейс для работы с текстовыми пользовательскими интерфейсами. Он необходим для многих утилит и компиляторов.

---

### 🔹 1. Убедитесь, что `gawk` используется вместо `mawk`

```bash
cd $DLFS/sources
tar -xf ncurses-6.5.tar.gz
cd ncurses-6.5
sed -i s/mawk// configure
```

> 🔧 **Зачем:** в некоторых системах `configure` может искать `mawk`, который может не поддерживать нужные функции. Мы явно указываем использовать `gawk` (должен быть уже установлен ранее).

---

## 🔹 2. Сборка утилиты `tic` на хосте

```bash
mkdir build
pushd build
../configure
make -C include
make -C progs tic
popd
```

> 🧱 **Что делает `tic`:** это утилита, которая преобразует описание терминалов из текстового формата в бинарную базу данных терминалов. Нам нужна **версия `tic`, работающая на хосте**, чтобы она могла использоваться при установке в `$DLFS`.

---

## 🔹 3. Конфигурация пакета Ncurses для кросс-сборки

```bash
./configure --prefix=/usr \
            --host=$DLFS_TGT \
            --build=$(./config.guess) \
            --mandir=/usr/share/man \
            --with-manpage-format=normal \
            --with-shared \
            --without-normal \
            --with-cxx-shared \
            --without-debug \
            --without-ada \
            --disable-stripping
```

### 📖 Расшифровка параметров:

- `--prefix=/usr` — стандартный префикс установки.
    
- `--host=$DLFS_TGT` — целевая система LFS.
    
- `--build=$(./config.guess)` — текущая хост-система.
    
- `--mandir=/usr/share/man` — путь для установки man-страниц.
    
- `--with-manpage-format=normal` — установка **не сжатых** man-страниц (иначе могут быть недоступны).
    
- `--with-shared` — собираем **разделяемые библиотеки**.
    
- `--without-normal` — **не собираем статические библиотеки**.
    
- `--with-cxx-shared` — собираем только **разделяемые C++-привязки**.
    
- `--without-debug` — не собираем debug-версии библиотек.
    
- `--without-ada` — отключаем поддержку языка Ada (он не нужен и может вызвать проблемы в chroot).
    
- `--disable-stripping` — не применять `strip` с хоста, чтобы не повредить бинарники кросс-сборки.
    

---

## 🔹 4. Сборка пакета

```bash
bash -c "$MAKE_CMD"
```

---

## 🔹 5. Установка в `$DLFS`

```bash
make DESTDIR=$DLFS TIC_PATH=$(pwd)/build/progs/tic install
```

### 💡 Пояснение:

- `DESTDIR=$DLFS` — установка в среду DLFS, а не на хост.
    
- `TIC_PATH=...` — указываем путь до `tic`, собранной на хосте, иначе установка базы терминалов может завершиться ошибкой.
    

---

## 🔹 6. Создание символической ссылки на библиотеку

```bash
ln -sv libncursesw.so $DLFS/usr/lib/libncurses.so
```

> 📎 Некоторые пакеты ожидают `libncurses.so`, а не `libncursesw.so`. Поэтому создаётся символьная ссылка.

---

## 🔹 7. Исправление заголовка `curses.h`

```bash
sed -e 's/^#if.*XOPEN.*$/#if 1/' -i $DLFS/usr/include/curses.h
```

> 🔍 Заголовочный файл `curses.h` содержит условные определения, которые могут включать несовместимые структуры данных, если он думает, что используется обычная `libncurses`. Мы явно говорим использовать **широкую (wchar)** версию — совместимую с `libncursesw`.

---

## 📁 В результате будут установлены:

- Библиотеки: `/usr/lib/libncursesw.so`, `/usr/lib/libncurses.so` (ссылка)
    
- Заголовки: `/usr/include/curses.h`, и др.
    
- Утилита `tic` в `$DLFS/usr/bin`


## Очистка

```bash
rm -rf $DLFS/sources/ncurses-6.5
```
