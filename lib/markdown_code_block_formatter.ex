defmodule MarkdownCodeBlockFormatter do
  @moduledoc """
  Elixir formatter plugin for formatting Elixir code in Markdown files.
  """

  @behaviour Mix.Tasks.Format

  alias MarkdownCodeBlockFormatter.Formatter

  def features(_opts) do
    [sigils: [:M], extensions: [".md", ".markdown"]]
  end

  def format(contents, opts) do
    Formatter.format(contents, opts)
  end
end
