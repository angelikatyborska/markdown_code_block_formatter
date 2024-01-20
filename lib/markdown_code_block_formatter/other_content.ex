defmodule MarkdownCodeBlockFormatter.OtherContent do
  defstruct [:lines]

  @type t :: %__MODULE__{
          lines: [String.t()]
        }
end
