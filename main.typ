#import "template.typ": *

#set outline(title: "Table of contents")

#show: bubble.with(
  title: "ZJU Bubble template",
  subtitle: "Simple and colorful template",
  author: "hzkonor",
  affiliation: "Zhejiang University",
  date: datetime.today().display("[year] 年 [month padding:none] 月 [day padding:none] 日"),
  year: "Year",
  class: "Class",
  other: ("Made with Typst", "https://typst.com")
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


Figures are customized but this is settable in the template file. You can of course reference them  : @ref.

#figure(caption: [Code example],
```rust
fn main() {
  println!("Hello Typst!");
}
```
)<ref>

#pagebreak()

= Enjoy !

#lorem(100)