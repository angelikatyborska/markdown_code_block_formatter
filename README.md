# Markdown Code Block Formatter

![GitHub Workflow status](https://github.com/angelikatyborska/markdown_code_block_formatter/actions/workflows/test.yml/badge.svg)
![version on Hex.pm](https://img.shields.io/hexpm/v/markdown_code_block_formatter)
![number of downloads on Hex.pm](https://img.shields.io/hexpm/dt/markdown_code_block_formatter)
![license on Hex.pm](https://img.shields.io/hexpm/l/markdown_code_block_formatter)

An Elixir formatter for Elixir code blocks in Markdown files and sigils.

It will **not** format any other part of your Markdown files.

![Running mix format formats your Elixir code in Markdown](https://raw.github.com/angelikatyborska/markdown_code_block_formatter/main/assets/mix-format.gif)

## Installation

The package can be installed by adding `markdown_code_block_formatter` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:markdown_code_block_formatter, "~> 0.1.0", runtime: false}
  ]
end
```

Then, extend your `.formatter.exs` config file by adding the plugin and inputs matching the location of your Markdown files. 

```elixir
# .formatter.exs
[
  plugins: [MarkdownCodeBlockFormatter],
  inputs: [
    # modify the line below to match the locations of your Markdown files
    "{docs,help}/*.{md,markdown}",
    # other files ...
  ]
]
```

Elixir 1.13 or up is required because lower versions do not support formatter plugins.

## Usage

Run `mix format`.

### Disabling the formatter for specific code blocks

If you want some of the Elixir code blocks to remain unformatted, you can precede the code block with a special ["comment"](https://www.jamestharpe.com/markdown-comments/):

````markdown
[//]: # (elixir-formatter-disable-next-block)

```elixir
# the two calls below are equivalent:
my_function(opt1: true, opt2: 60)
my_function([opt1: true, opt2: 60])
```
````

Note that Markdown does not have a syntax for comments, and the above is just a [reference-style link syntax](https://www.markdownguide.org/basic-syntax/#reference-style-links).

## Known limitations

### Whitespace stripping on empty lines

Imagine your Elixir code blocks are indented in your Markdown file. Like this:

````markdown
- This code block is part of the list item:
  ```elixir
  a = rem(x, 2)

  a * 10
  ```
````

On line nr 4, you could either have no characters, or have 2 spaces. This formatter will always strip all of your whitespaces from empty lines in Elixir code, forcing you into option 1.

This is my preferred behavior, but it should be possible to extend the formatter to accept an option that lets you choose either of the two. Let me know if you need that by opening a GitHub issue. 

### Indented (not fenced) code blocks

TL;DR: This formatter doesn't work well with indented code blocks. Use fenced code blocks instead.

Generally, this formatter will only format code blocks annotated as Elixir, and only fenced code blocks can specify their syntax. But that's not what this limitation is about.

Parsing indented code blocks is not implemented at all, which means all content inside an indented code block will be further parsed as Markdown. If your indented code block contains a fenced Elixir code block as content, that Elixir code block will get formatted even though it shouldn't.

I decided to ignore indented code blocks to simplify the parser implementation and save time.
