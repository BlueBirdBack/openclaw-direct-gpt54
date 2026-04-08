#!/usr/bin/env bash
set -euo pipefail

require_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Missing required command: $1" >&2
    exit 1
  fi
}

require_cmd python3
require_cmd sha256sum

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
mapfile -t skill_dirs < <(find "$ROOT/skills" -mindepth 1 -maxdepth 1 -type d | LC_ALL=C sort)

if [[ "${#skill_dirs[@]}" -ne 1 ]]; then
  echo "Expected exactly one skill directory under $ROOT/skills, found ${#skill_dirs[@]}." >&2
  exit 1
fi

SRC_DIR="${skill_dirs[0]}"
SKILL_NAME="$(basename "$SRC_DIR")"
DEFAULT_OUT="$ROOT/dist/$SKILL_NAME.skill"
OUT="${1:-$DEFAULT_OUT}"
OUT_DIR="$(dirname "$OUT")"

mkdir -p "$OUT_DIR"
rm -f "$OUT" "$OUT.sha256"

python3 - "$SRC_DIR" "$OUT" "$SKILL_NAME" <<'PY'
import os
import stat
import sys
import zipfile

src_dir, out_path, skill_name = sys.argv[1:4]
entries = []
for root, dirnames, filenames in os.walk(src_dir):
    dirnames.sort()
    filenames.sort()
    for filename in filenames:
        full_path = os.path.join(root, filename)
        rel_path = os.path.relpath(full_path, src_dir).replace(os.sep, "/")
        entries.append((f"{skill_name}/{rel_path}", full_path))

entries.sort(key=lambda item: item[0])
with zipfile.ZipFile(out_path, "w", compression=zipfile.ZIP_DEFLATED, compresslevel=9) as zf:
    for arcname, full_path in entries:
        st = os.stat(full_path)
        mode = stat.S_IMODE(st.st_mode)
        info = zipfile.ZipInfo(arcname)
        info.date_time = (2020, 1, 1, 0, 0, 0)
        info.create_system = 3
        info.external_attr = (stat.S_IFREG | mode) << 16
        info.compress_type = zipfile.ZIP_DEFLATED
        with open(full_path, "rb") as fh:
            data = fh.read()
        zf.writestr(info, data, compress_type=zipfile.ZIP_DEFLATED, compresslevel=9)
PY

sha256sum "$OUT" | awk '{print $1}' > "$OUT.sha256"
echo "Built $OUT"
