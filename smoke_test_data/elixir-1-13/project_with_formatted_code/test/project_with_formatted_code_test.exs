defmodule ProjectWithFormattedCodeTest do
  use ExUnit.Case
  doctest ProjectWithFormattedCode

  test "greets the world" do
    assert ProjectWithFormattedCode.hello() == :world
  end
end
