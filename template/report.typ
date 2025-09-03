// If you'd like to use the package (and if available), uncomment this:
// #import "@preview/zju-bubble-template:0.1.0": *
#import "template.typ": * // and remove this.

// and you can import any Typst package you want! For myself I usually use these.
#import "@preview/note-me:0.5.0": *
#import "@preview/cetz:0.4.1": canvas, draw, matrix, vector
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import fletcher.shapes: circle as fletcher_circle, hexagon, house

#show: bubble.with(
  title: "实验二：Typst模板实现",
  subtitle: "Typst短学期 (Typst101) 实验报告",
  author: "324010XXXX 犬戎",
  affiliation: "浙江大学 计算机科学与技术",
  date: datetime.today().display("[year] 年 [month padding:none] 月 [day padding:none] 日"),
  year: "课程综合实践I (CS1145M), 2025",
  // class: "Class",
  // other: ("Made with Typst", "https://typst.com")
)

= Introduction

This is a simple template that can be used for a report.

这是一个简单的模板，你可以用它来写报告。

= Feature 特性

== Colorful items

The main color can be set with the `main-color` property, which affects inline code, lists, links and important items. For example, the words highlight and important are highlighted !

- These bullet
- points
- are colored

+ It also
+ works with
+ numbered lists!

== Customized items

=== Codeblock
This is a codeblock.

```rust
use rand::Rng;
use std::cmp::Ordering;
use std::io;

fn main() {
    println!("Guess the number!");

    let secret_number = rand::thread_rng().gen_range(1..101);

    loop {
        println!("Please input your guess.");

        let mut guess = String::new();

        io::stdin()
            .read_line(&mut guess)
            .expect("Failed to read line");

        let guess: u32 = match guess.trim().parse() {
            Ok(num) => num,
            Err(_) => continue,
        };

        println!("You guessed: {}", guess);

        match guess.cmp(&secret_number) {
            Ordering::Less => println!("Too small!"),
            Ordering::Greater => println!("Too big!"),
            Ordering::Equal => {
                println!("You win!");
                break;
            }
        }
    }
}
```

代码块中英文使用「JetBrainsMonoNL NF」，中文使用「霞鹜文楷屏幕阅读版」。

```py
text = "未甚拔行间，犬戎大充斥"
print(text.encode())
```

=== Figures
Figures are customized. You can of course reference them: @figure1.

#figure(
  [
    #canvas(
      {
        import draw: *

        ortho(y: -30deg, x: 30deg, {
          on-xz({
            grid(
              (0, -2),
              (8, 2),
              stroke: gray + .5pt,
            )
          })

          // Draw a sine wave on the xy plane
          let wave(amplitude: 1, fill: none, phases: 2, scale: 8, samples: 100) = {
            line(
              ..(
                for x in range(0, samples + 1) {
                  let x = x / samples
                  let p = (2 * phases * calc.pi) * x
                  ((x * scale, calc.sin(p) * amplitude),)
                }
              ),
              fill: fill,
            )

            let subdivs = 8
            for phase in range(0, phases) {
              let x = phase / phases
              for div in range(1, subdivs + 1) {
                let p = 2 * calc.pi * (div / subdivs)
                let y = calc.sin(p) * amplitude
                let x = x * scale + div / subdivs * scale / phases
                line((x, 0), (x, y), stroke: rgb(0, 0, 0, 150) + .5pt)
              }
            }
          }

          on-xy({
            wave(amplitude: 1.6, fill: rgb(0, 0, 255, 50))
          })
          on-xz({
            wave(amplitude: 1, fill: rgb(255, 0, 0, 50))
          })
        })
      },
      length: 1.25cm,
    )
  ],
  caption: [Waves. (An example from #link("https://typst.app/universe/package/cetz/", "cetz"))],
)<figure1>

== Formula
假设 $sum_(n=1)^(infinity) a_n$ 是一个条件收敛的无穷级数。对任意的一个实数 $C$，都存在一种从自然数集合到自然数集合的排列 $sigma: n arrow.bar sigma(n)$，使得
$
  sum_(n=1)^(infinity) a_sigma(n) = C.
$

此外，也存在另一种排列 $sigma': n arrow.bar sigma'(n)$，使得
$
  sum_(n=1)^(infinity) a_(sigma'(n)) = infinity.
$

类似地，也可以有办法使它的部分和趋于 $-infinity$，或没有任何极限。

反之，如果级数是绝对收敛的，那么无论怎样重排，它仍然会收敛到同一个值，也就是级数的和。

= 这是一个使用例

以下提供一个真实的使用例，节选自某次课程实验报告 #"_(:з」∠)_"

== Qwen3 Decoder Layer

Qwen3 Decoder Layer 是一个标准的 Transformer 的 Decoder 架构，在此基础上 Layer Norm 部分使用了 RMS Norm。

#figure(
  [
    #let blob(pos, label, tint: white, ..args) = node(
      pos,
      align(center, label),
      width: 28mm,
      fill: tint.lighten(60%),
      stroke: 1pt + tint.darken(20%),
      ..args,
    )

    // #let c(..args) = circle(..args)
    #let circ(pos, tint: white, ..args) = node(
      pos,
      align(center, box(baseline: -2pt)[$+$]),
      fill: tint,
      stroke: 1pt + black,
      shape: fletcher_circle,
      radius: 2.5mm,
      ..args,
    )

    #diagram(
      spacing: 8pt,
      cell-size: (8mm, 10mm),
      edge-stroke: 1pt,
      edge-corner-radius: 5pt,
      mark-scale: 70%,

      circ((0, 1)),
      edge(),
      blob((0, 2), [Grouped Query\ Attention], tint: orange),
      blob((0, 3.3), [RMS Norm], tint: yellow, shape: hexagon),
      edge(),
      blob((0, 5), [Input], shape: house.with(angle: 30deg), width: auto, tint: red),

      for x in (-.3, -.1, +.1, +.3) {
        edge((0, 2.8), (x, 2.8), (x, 2), "-|>")
      },
      edge((0, 2.8), (0, 4)),
      edge((0, 4), "r,uuu,l", "--|>"),
      edge((0, 1), (0, 0.35), "rr", (2, 4), "r", (3, 3.3), "-|>"),
      edge((3, 4), "r,uuu,l", "--|>"),

      blob((3, 0), [Output], tint: green),
      edge("<|-"),
      circ((3, 1)),
      edge(),
      blob((3, 2), [Feed\ Forward], tint: blue),
      edge(),
      blob((3, 3.3), [RMS Norm], tint: yellow, shape: hexagon),
    )
  ],
  caption: [Overview of Qwen3 Decoder Layer.],
)

== LayerNorm 与 RMSNorm
LayerNorm 主要对每个 token 的特征向量进行归一化计算，其公式为

$
  "LayerNorm"(bold(x)) = bold(gamma) dot.circle frac(bold(x) - hat(mu), hat(sigma)) + bold(beta).
$

其中
$
  hat(mu) = 1/d sum_(i=1)^d x_i, \
  hat(sigma)^2 = 1/d sum_(i=1)^d (x_i - mu)^2 + epsilon,
$

$epsilon$ 是防止除零的小常数。$bold(beta), bold(gamma) in RR^d$ 是可学习的偏移参数与缩放参数，代表着把第 $i$ 个特征的 batch 分布的均值和方差移动到 $beta_i, gamma_i$.

RMSNorm 由论文 Root Mean Square Layer Normalization (#link("https://arxiv.org/abs/1910.07467", "arXiv:1910.07467")) 提出，其提出动机是传统的 LayerNorm 运算量比较大；而相比 LayerNorm，RMSNorm 不需要同时计算均值和方差两个统计量，而只需要计算均方根这一个统计量，性能和 LayerNorm 相当的同时节省了运算。RMSNorm 的公式为

$
  "RMSNorm"(bold(x)) = bold(gamma) dot.circle frac(bold(x), "RMS"(bold(x))),
$

其中 $"RMS"(bold(x))$ 是求均方根操作，公式为

$
  "RMS"(bold(x)) = sqrt(1/d sum_(i=1)^d x_i^2 + epsilon),
$
$epsilon$ 是防止除零的小常数。$bold(gamma) in RR^d$ 是可学习的缩放参数。

== Grouped Query Attention

首先需要了解 Multi-head Attention 与其变体 Multi-query Attention。MQA 在 MHA 的基础上，让所有的头之间共享同一份 $K, V$，每个头只单独保留了一份 $Q$，节省了大量 $K, V$。

而 GQA 实则是 MHA 与 MQA 的一个中间态，它选择的是使用 $n$ 份 $Q$ 对应一份 $K, V$。也就是说 GQA-1 即为 MHA，GQA-$n$ 即为 MQA。GQA 在节省 $K, V$ 的同时，且在实践中性能仍与经典的 MHA 相近。

#figure(
  [
    #let blob(pos, label, tint: white, ..args) = node(
      pos,
      align(center, label),
      width: 26pt,
      height: 40pt,
      fill: tint.lighten(60%),
      stroke: 1pt + tint.darken(20%),
      shape: rect,
      corner-radius: 5pt,
      ..args,
    )

    #let q(pos, label, ..args) = blob(pos, label, tint: color.aqua, ..args)
    #let k(pos, label, ..args) = blob(pos, label, tint: color.red.lighten(35%), ..args)
    #let v(pos, label, ..args) = blob(pos, label, tint: color.orange.lighten(35%), ..args)
    #let t(pos, label) = node(pos, box(label, height: 20pt, width: 100pt), shape: rect, width: 30pt)

    #block(inset: -5pt)

    #diagram(
      spacing: 6pt,
      cell-size: (8mm, 20mm),
      edge-stroke: 1pt,
      edge-corner-radius: 5pt,
      mark-scale: 70%,

      for i in range(4) {
        q((i, 2), [$Q_#(i + 1)$])
        edge("--|>")
        k((i, 1), [$K_#(i + 1)$])
        edge("-")
        v((i, 0.15), [$V_#(i + 1)$])
      },


      for i in range(2) {
        q((5 + 2 * i, 2), [$Q_#(10 * i + 11)$])
        edge("--|>", (5.5 + 2 * i, 1))
        q((6 + 2 * i, 2), [$Q_#(10 * i + 12)$])
        edge("--|>", (5.5 + 2 * i, 1))
        k((5.5 + 2 * i, 1), [$K_#(i + 1)$])
        edge("-")
        v((5.5 + 2 * i, 0.15), [$V_#(i + 1)$])
      },

      for i in range(4) {
        q((10 + i, 2), [$Q_#(i + 1)$])
        edge("--|>", (11.5, 1))
      },
      k((11.5, 1), [$K$]),
      edge("-"),
      v((11.5, 0.15), [$V$]),

      t((1.5, 2.55), [Multi-head]),
      t((6.5, 2.55), [Grouped-query]),
      t((11.5, 2.55), [Multi-query]),
    )
  ],
  caption: [Overview of grouped-query method.],
)

== Feed Forward Network with Gated Linear Unit

Transformer 中经典的 FFN 通常由一个含偏置的线性层、一个激活函数 $sigma$ 再一个含偏置的线性层组成。FFN 的公式可以写作

$
  "FFN"(x) = W_d dot sigma(W_u dot x + b_u) + b_d.
$

#note[所以也可以见到将 FFN 这一组件叫作 MLP 的称呼，例如实验框架中 FFN 类的类名就叫作 `Qwen3MLP`。不过有一点小出入是，在 Transformer 之外一般所说的经典双层 MLP 每一个神经元都会有一个 $sigma$，于是最后还会有一个 $sigma$。）]

而 Gated Linear Unit 可以理解为第一层线性层的一个替代，其核心思想是使用一个带参数的门控层 $sigma(W_g dot x)$ 代替简单激活函数 $sigma$，从而更精确地控制信息的流动；另外使用 GLU 的 FFN 实现通常会去掉偏置。

GLU 的公式可以写作

$
  "GLU"(x) = sigma(W_g dot x) dot.circle (W_u dot x).
$
#tip[
  对比之下，前面提到的经典 FFN 中的第一层线性层可以写作

  $
    "FFN"_1(x) = sigma(W_u dot x + b_u).
  $
]

则 FFN with GLU 可以写作

$
  "FFN"'(x) = W_d "GLU"(x) = W_d dot (sigma(W_g dot x) dot.circle (W_u dot x)).
$

#figure(
  [
    #let blob(pos, label, tint: white, width: auto, ..args) = node(
      pos,
      align(center, label),
      width: width,
      fill: tint.lighten(60%),
      stroke: 1pt + tint.darken(20%),
      corner-radius: 5pt,
      ..args,
    )

    // #let c(..args) = circle(..args)
    #let circ(pos, tint: white, ..args) = node(
      pos,
      align(center, box(baseline: -2pt)[$times$]),
      fill: tint,
      stroke: 1pt + black,
      shape: fletcher_circle,
      radius: 2.5mm,
      ..args,
    )

    #let text(pos, label) = node(pos, box(label, height: 20pt, width: 100pt), shape: rect, width: 30pt)

    #let c_i = red
    #let c_o = green
    #let c_u = orange
    #let c_d = blue.lighten(20%)
    #let c_g = yellow
    #let c_s = luma(80%)

    #diagram(
      spacing: 8pt,
      cell-size: (19mm, 8mm),
      edge-stroke: 1pt,
      edge-corner-radius: 5pt,
      mark-scale: 70%,

      blob((0, 6), [Input], shape: house.with(angle: 30deg), tint: c_i),
      edge("-|>"),
      blob((0, 4), [Up projection \ $W_u$ (with bias)], width: 110pt, tint: c_u),
      edge("-"),
      blob((0, 2), [$sigma$], tint: c_s),
      edge("-|>"),
      blob((0, 0.75), [Down projection \ $W_d$ (with bias)], width: 110pt, tint: c_d),
      edge("-|>"),
      blob((0, -0.65), [Output], tint: c_o, corner-radius: 0pt),

      blob((2, 6), [Input], shape: house.with(angle: 30deg), tint: red),
      edge("-|>"),
      edge((2, 6), (2, 4.95), "r,u", "--|>"),
      blob((2, 4), [Up projection \ $W_u$], width: 110pt, tint: c_u),
      edge("-"),
      circ((2, 2)),
      edge("-|>"),
      blob((2, 0.75), [Down projection \ $W_d$], width: 110pt, tint: c_d),
      edge("-|>"),
      blob((2, -0.65), [Output], tint: c_o, corner-radius: 0pt),
      blob((3, 4), [Gate projection \ $W_g$], width: 110pt, tint: c_g),
      edge("--|>"),
      blob((3, 2.8), [$sigma$], tint: c_s),
      edge((3, 2.8), (3, 2), (2, 2), "--|>"),

      text((0, 6.9), [Classic FFN]),
      text((2.4, 6.9), [FFN with GLU]),
    )
  ],
  caption: [Comparison of classic FFN and FFN with GLU],
)
