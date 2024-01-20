defmodule MarkdownCodeBlockFormatter.Parser do
  alias MarkdownCodeBlockFormatter.ElixirCode
  alias MarkdownCodeBlockFormatter.OtherContent
  alias MarkdownCodeBlockFormatter.Indentation

  @spec parse(String.t()) :: [ElixirCode.t() | OtherContent.t()]
  def parse(content) do
    lines = String.split(content, "\n")

    parse_lines(lines, %{
      in_code_block: false,
      in_elixir_code_block: false,
      code_block_tag: nil,
      chunks: []
    })
  end

  defp parse_lines([], acc) do
    acc.chunks
    |> Enum.reverse()
    |> Enum.map(fn content ->
      %{content | lines: Enum.reverse(content.lines)}
    end)
  end

  defp parse_lines([line | rest], acc) do
    acc =
      if acc.in_code_block do
        case code_block_end(line, acc.code_block_tag) do
          nil ->
            chunks = append_to_current_chunk(acc.chunks, line)
            %{acc | chunks: chunks}

          true ->
            chunks =
              if acc.in_elixir_code_block do
                [%OtherContent{lines: [line]} | acc.chunks]
              else
                append_to_current_chunk(acc.chunks, line)
              end

            %{
              acc
              | in_code_block: false,
                in_elixir_code_block: false,
                code_block_tag: nil,
                chunks: chunks
            }
        end
      else
        case code_block_start(line) do
          nil ->
            chunks = append_to_current_or_new_chunk(acc.chunks, %OtherContent{}, line)
            %{acc | chunks: chunks}

          {"elixir", opening_tag} ->
            chunks = append_to_current_or_new_chunk(acc.chunks, %OtherContent{}, line)

            chunks = [
              %ElixirCode{indentation: Indentation.detect_indentation(line), lines: []} | chunks
            ]

            %{
              acc
              | in_code_block: true,
                in_elixir_code_block: true,
                code_block_tag: opening_tag,
                chunks: chunks
            }

          {_other_language, opening_tag} ->
            chunks = append_to_current_or_new_chunk(acc.chunks, %OtherContent{}, line)

            %{
              acc
              | in_code_block: true,
                in_elixir_code_block: false,
                code_block_tag: opening_tag,
                chunks: chunks
            }
        end
      end

    parse_lines(rest, acc)
  end

  defp code_block_start(line) do
    case Regex.run(~r/(\s|\t)*(`{3,}|~{3,})([A-z]*)((\s|\t)*)$/, line) do
      nil ->
        nil

      [_, _indentation, opening_tag, language | _] ->
        {language, opening_tag}
    end
  end

  defp code_block_end(line, opening_tag) do
    case Regex.run(Regex.compile!("^(\\s*|\\t*)(#{opening_tag})(\\s*|\\t*)$"), line) do
      nil ->
        nil

      [_, _indentation, _closing_tag, _language | _] ->
        true
    end
  end

  defp append_to_current_or_new_chunk([], struct, line) do
    [%{struct | lines: [line]}]
  end

  defp append_to_current_or_new_chunk([current_chunk | rest], _, line) do
    [%{current_chunk | lines: [line | current_chunk.lines]} | rest]
  end

  defp append_to_current_chunk([current_chunk | rest], line) do
    [%{current_chunk | lines: [line | current_chunk.lines]} | rest]
  end
end
