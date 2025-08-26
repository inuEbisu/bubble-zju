# zju-bubble-template

浙江大学风格的 Typst 模板，基于 [hzkonor/bubble-template](https://github.com/hzkonor/bubble-template) 二次开发。

## 特点

- 大气的浙大蓝与浙大校徽，搭配 bubble-template 的简洁彩色风格
- 支持自定义主色、作者、标题、日期、Logo 等
- 页眉自动显示标题与作者，页脚自动显示页码

适用于浙江大学各类文档、作业、报告等场景。

## 预览

见仓库中的 `main.typ` 示例及其导出的 `main.pdf`。

| 封面                            | 使用例                                 |
| ------------------------------- | -------------------------------------- |
| ![main page](assets/main_1.png) | ![List of features](assets/main_4.png) |

## 使用

目前需要克隆仓库到工作目录下，再使用 `#import` 语句导入。随后就和 `main.typ` 中一样。

```typ
#import "zju-bubble-template/template.typ"
```

预期在上传至 Typst Universe 后可以这样进行导入，不过目前还没有传：

```typ
#import "@preview/zju-bubble-template:0.1.0": *
```

没有内置字体，您可能需要安装以下字体：

```typ
#let needed-font = (
    "Barlow",
    "Source Han Sans SC",
    "JetBrainsMonoNL NF",
    "LXGW WenKai Mono Screen"
)
```

## License

MIT-0 License, consistent with [hzkonor/bubble-template](https://github.com/hzkonor/bubble-template).