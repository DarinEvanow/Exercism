defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    Enum.filter(candidates, fn candidate -> do_match(base, candidate) end)
  end

  defp do_match(base, candidate) do
    not same_word?(base, candidate) &&
    process(base) === process(candidate)
  end

  defp same_word?(first_word, second_word) do
    String.downcase(first_word) === String.downcase(second_word)
  end

  defp process(word) do
    word
    |> String.downcase
    |> String.graphemes
    |> Enum.sort
  end
end
