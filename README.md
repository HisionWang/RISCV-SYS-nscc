# 嵌入式智能计算系统解决方案

当前版本为 **v0.3 首轮正文**，技术依据为 [TP-0.2 技术选型与可行性报告](../technical-planning/06-current-selection-feasibility-report.md)。用户已授权依据该基线填写方案；本稿描述研究设计，尚无工程实测结果。

## 阅读与编译

- 最新正文 PDF：[`output/solution-draft.pdf`](output/solution-draft.pdf)。
- 主文件：[`main.tex`](main.tex)，章节位于 `sections/`。
- 配置总索引：[`config/README.md`](config/README.md)。

在本目录运行：

~~~powershell
powershell -ExecutionPolicy Bypass -File .\scripts\build.ps1
~~~

脚本自动寻找 XeLaTeX 或项目内 Tectonic；也可通过 `-EnginePath` 指定编译器。输出文件为 `output/solution-draft.pdf`，日志及中间文件位于 `build/`。项目内便携依赖与字体缓存位于 `../tmp/latex-tools/`，不改变系统 PATH。不要使用 pdfLaTeX。

## 文档组织

按提供的解决方案范例组织：**封面 → 摘要 → 目录 → 八章正文 → 附件与参考资料**。

八章依次为命题概述、命题分析、行业背景分析、实现方案、技术创新、项目应用情况、团队介绍、个人成长与教育情况。第四章集中描述架构、选型、接口、模型、启动、操作系统和验证。旧项目策划书仅参考内容讲述，不决定本稿文种，也不移用旧项目成果。

v0.1、v0.2 排版结构分别保存在 `archive/layout-v0.1/`、`archive/layout-v0.2/`。此前 `solution-layout.pdf` 为旧排版预览；以 `solution-draft.pdf` 为当前正文。

## 配置归属

| 文件 | 修改内容 |
|---|---|
| `config/document.tex` | 文档、赛事、工作名称、版本、企业评价状态 |
| `config/people.tex` | 负责人、导师、成员信息与建议岗位 |
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
| `config/appearance.tex` | 纸张、页边距、行距与颜色 |
| `config/presentation.tex` | 后续讲述提纲的可修改关键词 |

正文调用宏，不在不同章节重复维护同一型号或名称。`ProjectName` 为本版工作名称，可在配置中统一替换；未确认的个人信息仍显示“待补充”。宏索引可运行 `scripts/update-config-index.py` 更新。

## 后续修订

1. 在个人配置中确认负责人、学校、团队名称和联系方式。
2. 审阅本版系统讲述与图表，按反馈修改对应配置及章节。
3. 后续工程结果形成后，补充模型来源、资源、时序、数值测试及企业反馈；本轮不填造实测数据。
4. 文书可以领先实现多个版本；每次变更记录其技术基线，接口和实际配置同步复核。

图表由 LaTeX/TikZ 原生生成，技术标签引用配置宏。中文字体优先使用本机字体副本，其他环境回退到 TeX Fandol；字体副本仅作本机编译依赖。
