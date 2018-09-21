defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    string_without_symbols = String.replace(sentence, ~r/[\W0-9_]+/, "")
    String.length(string_without_symbols) ==
      string_without_symbols
      |> String.to_charlist
      |> Enum.uniq
      |> Enum.count
  end
end
