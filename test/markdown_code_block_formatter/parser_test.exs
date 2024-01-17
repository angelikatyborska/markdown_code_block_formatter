defmodule MarkdownCodeBlockFormatter.ParserTest do
  use ExUnit.Case

  import MarkdownCodeBlockFormatter.Parser
  alias MarkdownCodeBlockFormatter.ElixirCode
  alias MarkdownCodeBlockFormatter.OtherContent

  describe "parse/1" do
    test "one line, no code" do
      assert parse("") == [%OtherContent{lines: [""]}]
      assert parse("abc") == [%OtherContent{lines: ["abc"]}]
      assert parse("    ") == [%OtherContent{lines: ["    "]}]
    end

    test "few lines, no code" do
      assert parse("# Hello, World!\n\nLorem ipsum.") == [
               %OtherContent{lines: ["# Hello, World!", "", "Lorem ipsum."]}
             ]

      assert parse("  - one\n  - two\n") == [%OtherContent{lines: ["  - one", "  - two", ""]}]
    end

    test "few lines, only elixir code, backticks" do
      assert parse("```elixir\n1 + 2\n```") == [
               %OtherContent{lines: ["```elixir"]},
               %ElixirCode{lines: ["1 + 2"], indentation: {:spaces, 0}},
               %OtherContent{lines: ["```"]}
             ]

      assert parse("  ```elixir\n  1 + 2\n  ```") == [
               %OtherContent{lines: ["  ```elixir"]},
               %ElixirCode{lines: ["  1 + 2"], indentation: {:spaces, 2}},
               %OtherContent{lines: ["  ```"]}
             ]

      assert parse("  `````elixir\n  1 + 2\n  `````") == [
               %OtherContent{lines: ["  `````elixir"]},
               %ElixirCode{lines: ["  1 + 2"], indentation: {:spaces, 2}},
               %OtherContent{lines: ["  `````"]}
             ]

      assert parse("    `````elixir\n    def add(a, b) do\n      a + b\n    end\n    `````") == [
               %OtherContent{lines: ["    `````elixir"]},
               %ElixirCode{
                 lines: ["    def add(a, b) do", "      a + b", "    end"],
                 indentation: {:spaces, 4}
               },
               %OtherContent{lines: ["    `````"]}
             ]
    end

    test "few lines, only elixir code, tildes" do
      assert parse("~~~elixir\n1 + 2\n~~~") == [
               %OtherContent{lines: ["~~~elixir"]},
               %ElixirCode{lines: ["1 + 2"], indentation: {:spaces, 0}},
               %OtherContent{lines: ["~~~"]}
             ]

      assert parse("  ~~~elixir\n  1 + 2\n  ~~~") == [
               %OtherContent{lines: ["  ~~~elixir"]},
               %ElixirCode{lines: ["  1 + 2"], indentation: {:spaces, 2}},
               %OtherContent{lines: ["  ~~~"]}
             ]

      assert parse("  ~~~~~elixir\n  1 + 2\n  ~~~~~") == [
               %OtherContent{lines: ["  ~~~~~elixir"]},
               %ElixirCode{lines: ["  1 + 2"], indentation: {:spaces, 2}},
               %OtherContent{lines: ["  ~~~~~"]}
             ]

      assert parse("    ~~~~~elixir\n    def add(a, b) do\n      a + b\n    end\n    ~~~~~") == [
               %OtherContent{lines: ["    ~~~~~elixir"]},
               %ElixirCode{
                 lines: ["    def add(a, b) do", "      a + b", "    end"],
                 indentation: {:spaces, 4}
               },
               %OtherContent{lines: ["    ~~~~~"]}
             ]
    end

    test "few lines, only javascript code" do
      assert parse("```js\n1 + 2\n```") == [
               %OtherContent{lines: ["```js", "1 + 2", "```"]}
             ]

      assert parse("  ~~~js\n  1 + 2\n  ~~~") == [
               %OtherContent{lines: ["  ~~~js", "  1 + 2", "  ~~~"]}
             ]

      assert parse("  `````js\n  1 + 2\n  `````") == [
               %OtherContent{lines: ["  `````js", "  1 + 2", "  `````"]}
             ]

      assert parse("  `````js\n  1 + 2\n  10 - 2\n  `````") == [
               %OtherContent{lines: ["  `````js", "  1 + 2", "  10 - 2", "  `````"]}
             ]
    end

    test "few lines, only code, no syntax specified" do
      assert parse("```\n1 + 2\n```") == [
               %OtherContent{lines: ["```", "1 + 2", "```"]}
             ]

      assert parse("  ~~~\n  1 + 2\n  ~~~") == [
               %OtherContent{lines: ["  ~~~", "  1 + 2", "  ~~~"]}
             ]

      assert parse("  `````\n  1 + 2\n  `````") == [
               %OtherContent{lines: ["  `````", "  1 + 2", "  `````"]}
             ]

      assert parse("  `````\n  1 + 2\n  10 - 2\n  `````") == [
               %OtherContent{lines: ["  `````", "  1 + 2", "  10 - 2", "  `````"]}
             ]
    end

    # TODO: test code blocks "nested" in code blocks
    # TODO: test more than one code block in file
    # TODO: test complex example
    # TODO: test non-fenced code blocks
    # TODO: test inline code does not interfere
  end
end
