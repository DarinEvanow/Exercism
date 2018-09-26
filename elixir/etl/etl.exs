defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(map) :: map
  def transform(input) do
    input
    |> Enum.reduce(%{}, &invert/2)
  end

  defp invert({value, words}, acc) do
    words
    |> Enum.map(&({String.downcase(&1), value}))
    |> Enum.into(%{})
    |> Map.merge(acc)
  end
end
