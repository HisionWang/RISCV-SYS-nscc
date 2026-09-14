# 嵌入式智能计算系统解决方案

解决方案已补充团队成员与指导教师信息，并完善软硬件架构图和页面视觉样式，技术依据为 [技术选型与可行性报告](../technical-planning/06-current-selection-feasibility-report.md)。PDF 不显示文档修订编号、稿件状态标签和封面日期；封面突出比赛名称与完整赛题。用户已授权依据该基线填写方案；本稿描述研究设计，尚无工程实测结果。

## 阅读与编译

- 最新正文 PDF：[`output/solution-draft.pdf`](output/solution-draft.pdf)；根目录 `main.pdf` 同步保留相同内容。
- 主文件：[`main.tex`](main.tex)，章节位于 `sections/`。
- 配置总索引：[`config/README.md`](config/README.md)。

在本目录运行：

~~~powershell
powershell -ExecutionPolicy Bypass -File .\scripts\build.ps1
~~~

脚本自动寻找 XeLaTeX 或项目内 Tectonic；也可通过 `-EnginePath` 指定编译器。输出文件为 `output/solution-draft.pdf`，日志及中间文件位于 `build/`。项目内便携依赖与字体缓存位于 `../tmp/latex-tools/`，不改变系统 PATH。不要使用 pdfLaTeX。

## 文档组织

按提供的解决方案范例组织：**封面 → 摘要 → 目录 → 正文 → 附件与参考资料**。

正文依次为命题概述、命题分析、用户需求分析、行业背景分析、实现方案、技术创新、项目应用情况、团队介绍、个人成长与教育情况。实现方案章集中描述架构、选型、接口、模型、启动、操作系统和验证；用户需求分析章说明智能家居等边缘场景的需求与计算约束。旧项目策划书仅参考内容讲述，不决定本稿文种，也不移用旧项目成果。商业价值分析章待用户需求分析定稿后补充。

v0.1、v0.2 排版结构分别保存在 `archive/layout-v0.1/`、`archive/layout-v0.2/`。此前 `solution-layout.pdf` 为旧排版预览；以 `solution-draft.pdf` 为当前正文。

## 配置归属

| 文件 | 修改内容 |
|---|---|
| `config/document.tex` | 文档、赛事、工作名称、企业评价状态 |
| `config/people.tex` | 负责人、导师学历与任职、研究方向与指导内容、成员履历及照片路径 |
| `config/hardware.tex` | 板卡、处理器、向量单元、加速器、DDR 与器件资源 |
| `config/software.tex` | 操作系统、工具链、运行体系及部署方式 |
| `config/models.tex` | 首个验证模型、形状、类型、量化及结构核算 |
| `config/functions.tex` | 采集、通信、推理与应用功能 |
| `config/metrics.tex` | 目标定义、条件和验证方法 |
| `config/requirements.tex` | 题目需求与响应、验收方法 |
| `config/milestones.tex` | 进度、里程碑与文档领先版本数 |
| `config/versions.tex` | 固定源码提交 |
| `config/sources.tex` | 参考来源标题与链接 |
| `config/source-brief.tex` | 企业题面原文，核对来源后才能变更 |
| `config/appearance.tex` | 纸张、页边距、行距、颜色、封面字号与背景装饰强度 |
| `config/diagrams.tex` | 软硬件架构图节点、接口标签和图题 |
| `config/presentation.tex` | 后续讲述提纲的可修改关键词 |

正文调用宏，不在不同章节重复维护同一型号或名称。`ProjectName` 为本版工作名称，可在配置中统一替换；未确认的个人信息仍显示“待补充”。宏索引可运行 `scripts/update-config-index.py` 更新。

## 后续修订

1. 在 config/people.tex 审阅成员履历、专业名称及导师资料，补充剩余个人信息。
2. 审阅本版系统讲述与图表，按反馈修改对应配置及章节。
3. 后续工程结果形成后，补充模型来源、资源、时序、数值测试及企业反馈；本轮不填造实测数据。
4. 文书可以领先实现多个版本；每次变更记录其技术基线，接口和实际配置同步复核。

图表由 LaTeX/TikZ 原生生成，技术标签引用配置宏。两张架构图位于 `assets/diagrams/`，背景位于 `styles/background.tex`；沿用原章节结构。视觉上参考往年互联网+作品的蓝色主题和页边电路线，采用白底正文、浅蓝几何底纹及少量青蓝强调。中文字体优先使用本机字体副本，其他环境回退到 TeX Fandol；字体副本仅作本机编译依赖。

## Git 协作

后续修改以本仓库为基线，遵循 [AGENTS.md](AGENTS.md)：在工作分支完成局部修改、编译和审阅，用户确认后再合入 main 并推送。
