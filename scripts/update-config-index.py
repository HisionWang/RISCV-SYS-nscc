from pathlib import Path
import re
root = Path(__file__).resolve().parents[1]
lines = ["# 配置宏索引", "", "由 scripts/update-config-index.py 生成。业务值在对应 .tex 文件中维护。", ""]
count = 0
for file in sorted((root / "config").glob("*.tex")):
    entries = []
    for number, line in enumerate(file.read_text(encoding="utf-8").splitlines(), 1):
        match = re.search(r"\\newcommand\{\\([A-Za-z]+)\}", line)
        if match:
            entries.append((match.group(1), number))
    if entries:
        lines += ["## " + file.name, "", "| 宏 | 定义位置 |", "|---|---|"]
        for name, number in entries:
            lines.append("| `\\" + name + "` | [" + str(number) + "](<" + file.name + "#L" + str(number) + ">) |")
        lines.append("")
        count += len(entries)
(root / "config" / "README.md").write_text("\n".join(lines), encoding="utf-8")
print(f"Indexed {count} macros.")
