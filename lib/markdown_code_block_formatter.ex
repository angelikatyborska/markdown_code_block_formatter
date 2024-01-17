defmodule MarkdownCodeBlockFormatter do
  @moduledoc """
  Elixir formatter plugin for formatting Elixir code in Markdown files.
  """

  @behaviour Mix.Tasks.Format

  def features(_opts) do
    [sigils: [:M], extensions: [".md", ".markdown"]]
  end

  def format(contents, _opts) do
    contents
  end
end
