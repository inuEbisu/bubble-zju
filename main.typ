#import "template.typ": *

#set outline(title: "Table of contents")

#show: bubble.with(
  title: "实验二：Typst模板实现",
  subtitle: "Lab2 - Typst Template Implementation",
  author: "324010XXXX 犬戎",
  affiliation: "浙江大学 计算机科学与技术",
  date: datetime.today().display("[year] 年 [month padding:none] 月 [day padding:none] 日"),
  year: "Typst 短学期 (Typst101) 2025",
  // class: "Class",
  // other: ("Made with Typst", "https://typst.com")
)

// Edit this content to your liking

= Introduction

This is a simple template that can be used for a report.

= Features
== Colorful items

The main color can be set with the `main-color` property, which affects inline code, lists, links and important items. For example, the words highlight and important are highlighted !

- These bullet
- points
- are colored

+ It also
+ works with
+ numbered lists!

== Customized items

This is a codeblock.

```rust
fn main() {
  println!("Hello Typst!");
}
```

Figures are customized but this is settable in the template file. You can of course reference them  : @ref.

#figure(caption: [Code example], ```rust
fn main() {
  println!("Hello Typst!");
}
```)<ref>

#figure(rect("This is a figure."), caption: "What a figure!")

#figure(rect("This is another figure."), caption: "What a figure!")

#pagebreak()

= Enjoy !

#lorem(100)
