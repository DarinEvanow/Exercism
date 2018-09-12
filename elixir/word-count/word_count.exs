defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    words = String.downcase(sentence) |> String.split(~r/[^a-zA-Z0-9-äöüÄÖÜß]+/, trim: true)
    results = Enum.reduce words, %{}, fn word, acc -> Map.update acc, word, 1, &(&1 + 1)
    end
  end
end
