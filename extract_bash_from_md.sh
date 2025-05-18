
#!/usr/bin/env bash

# Использование: ./extract_ordered.sh "/path/to/markdown/folder" > full_script.sh

INPUT_DIR="${1:-.}"
OUTPUT="/dev/stdout"

echo "#!/usr/bin/env bash"
echo "# Автоматически сгенерированный скрипт из Markdown-файлов в ${INPUT_DIR}"
echo ""

# Ищем все .md файлы в указанной директории, сортируем по числовому префиксу
find "$INPUT_DIR" -maxdepth 1 -type f -name "*.md" \
    | sort -t '/' -k2V \
    | while read -r md_file; do
        echo "# ==== Из файла: $(basename "$md_file") ===="
        awk '
        BEGIN { inblock = 0 }
        /^```bash/ { inblock = 1; next }
        /^```/ { if (inblock) inblock = 0; next }
        inblock { print }
        ' "$md_file"
        echo ""
    done

