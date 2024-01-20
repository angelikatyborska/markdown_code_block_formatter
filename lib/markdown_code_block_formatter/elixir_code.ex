defmodule MarkdownCodeBlockFormatter.ElixirCode do
  @moduledoc false

  alias MarkdownCodeBlockFormatter.Indentation

  defstruct([:lines, :indentation])

  @type t :: %__MODULE__{
          lines: [String.t()],
          indentation: Indentation.t()
        }
end
