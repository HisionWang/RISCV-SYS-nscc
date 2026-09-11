# 方案书 LaTeX 排版骨架

当前版本只编排章节、讲述要点和内容槽位。技术规划经人工审阅前，正文保持槽位，不填具体选型、性能数值或成果结论。

## 编译

使用支持中文的 XeLaTeX，在本目录运行两次以更新目录和交叉引用：

```powershell
xelatex -interaction=nonstopmode -halt-on-error main.tex
xelatex -interaction=nonstopmode -halt-on-error main.tex
```

本项目已提供自动寻找 XeLaTeX 或项目内 Tectonic 的编译脚本：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\build.ps1
```

输出为 `output/project-proposal-layout.pdf`，日志与中间文件在 `build/`。也可用 `-EnginePath` 指定编译器。项目内便携编译器与缓存位于上一级 `tmp/latex-tools/`，不改变系统 PATH。不要用 pdfLaTeX 替代 XeLaTeX。


## 文件分工

`main.tex` 组织封面、目录和各章节，统一加载样式与 `config/config.tex`。`sections/01-overview.tex` 至 `sections/09-appendix.tex` 保存九个章节的讲述结构，不单独编译。

配置按内容归属修改：

| 文件 | 内容 |
|---|---|
| `config/config.tex` | 汇总加载配置文件 |
| `config/document.tex` | 文档、赛事、企业命题与项目名称 |
| `config/appearance.tex` | 页边距、行距和色值 |
| `config/people.tex` | 负责人、导师、成员姓名及职责 |
| `config/requirements.tex` | 每项需求依据、设计响应和确认方法 |
| `config/hardware.tex` | 现有硬件资产及待审阅的硬件配置 |
| `config/software.tex` | 系统、工具链、驱动及推理软件配置 |
| `config/functions.tex` | 功能与混合部署配置 |
| `config/metrics.tex` | 待审阅的目标指标 |
| `config/milestones.tex` | 阶段安排 |
| `config/presentation.tex` | 各章讲述标题与问题 |
| `config/source-brief.tex` | 企业命题内容和答题要求原文 |

原文通过宏在附件中呈现，不在各章重复维护。修改原文前应核对来源；已确认的现有资产与最终选型分别记录。

## 填写约定

- `\PendingValue` 仅控制所有未定值的显示文字。确定某个型号时，应修改对应的 `\ChipModel` 等字段，不要把 `\PendingValue` 全局替换为型号。正文只引用字段宏。
- `\ContentSlot{标题}{讲述提示}` 放待填写内容；`\FigureSlot{标题}{说明}` 放待制作图；`\KeyPoint{标题}{提示}` 提醒本节要回答的问题。
- 审阅通过后，按章节填写真实内容与图表，保留来源及完成状态，避免计划、估算和实测混写。
- 普通文本中的 LaTeX 特殊字符需要转义，例如 `\&`、`\%`、`\_`、`\#`、`\$`；不要把普通路径或含特殊字符的文本直接粘进宏定义。新增宏应在对应配置文件中定义后再引用。
- 版式在样式文件集中调整；各章使用 `\section`、`\subsection`，一级章节是否另起页由 `config/appearance.tex` 的 `\SectionPageBreak` 统一控制，不在章节内补空行凑页数。

## 与技术规划任务交接

另一任务仅在 `../technical-planning/` 输出选型与实施规划。其技术结论经人工审阅后，再按配置归属更新宏并填写章节。当前没有自动导入或自动批准选型的步骤。

中文字体由 `styles/fonts.tex` 管理：优先使用项目临时目录中的本机字体副本，其他机器回退到 TeX 的 Fandol 字体。字体副本仅作本机编译依赖，不作为项目素材分发。
