Вот оформленная в Markdown инструкция по установке **Gzip 1.13** с пояснениями:

---
## 🔧 Подготовка к компиляции

```bash
cd $DLFS/sources/
tar -xf gzip-1.13.tar.xz 
cd gzip-1.13 
mkdir -v build && cd build
../configure --prefix=/usr --host=$DLFS_TGT
```

### 📌 Пояснения:

- `--prefix=/usr` — установка всех файлов в системную директорию `/usr`;
    
- `--host=$DLFS_TGT` — сборка с использованием кросс-компиляции для временной DLFS-системы.
    

---

## 🛠️ Сборка

```bash
bash -c "$MAKE_CMD"
```

> Компилирует бинарные утилиты: `gzip`, `gunzip`, `zcat` и другие.

---

## 📥 Установка

```bash
make DESTDIR=$DLFS install
```

> Устанавливает собранные бинарники и документацию в директорию `$DLFS`.

---

После установки ты сможешь использовать `gzip` и `gunzip` в среде DLFS.

## Очистка

```bash
rm -rf $DLFS/sources/gzip-1.13
```
