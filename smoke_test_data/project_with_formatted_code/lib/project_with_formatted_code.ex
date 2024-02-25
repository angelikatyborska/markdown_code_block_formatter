defmodule ProjectWithFormattedCode do
  @moduledoc """
  Documentation for `ProjectWithFormattedCode`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ProjectWithFormattedCode.hello()
      :world

  """
  def hello do
    ~M"""
    # Hello, World!

    ```elixir
    def add(a, b), do: a + b
    ```

    ```js
    1+2+3
    ```
    """

    :world
  end
end
