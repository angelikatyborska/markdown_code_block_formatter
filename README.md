# Markdown Code Block Formatter

![GitHub Workflow status](https://github.com/github/docs/actions/workflows/test.yml/badge.svg)
![version on Hex.pm](https://img.shields.io/hexpm/v/markdown_code_block_formatter)
![number of downloads on Hex.pm](https://img.shields.io/hexpm/dt/markdown_code_block_formatter)
![license on Hex.pm](https://img.shields.io/hexpm/l/markdown_code_block_formatter)

An Elixir formatter for Elixir code blocks in Markdown files and sigils.

It will **not** format any other part of your Markdown files.

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
    # modify the line below to match locations of your Markdown files
    "{docs,help}/*.{md,markdown}",
    # other files ...
  ]
]
```

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
