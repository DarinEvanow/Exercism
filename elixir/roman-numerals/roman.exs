defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t()
  def numerals(0), do: ""
  def numerals(x) when x >= 1000, do: [?M | numerals(x - 1000)] |> to_string
  def numerals(x) when x >= 100,  do: digit(div(x, 100), "C", "D", "M") ++ numerals(rem(x, 100)) |> to_string
  def numerals(x) when x >= 10,   do: digit(div(x, 10), "X", "L", "C") ++ numerals(rem(x, 10)) |> to_string
  def numerals(x) when x >= 1,    do: digit(x, "I", "V", "X") |> to_string

  defp digit(1, x, _, _), do: [x]
  defp digit(2, x, _, _), do: [x, x]
  defp digit(3, x, _, _), do: [x, x, x]
  defp digit(4, x, y, _), do: [x, y]
  defp digit(5, _, y, _), do: [y]
  defp digit(6, x, y, _), do: [y, x]
  defp digit(7, x, y, _), do: [y, x, x]
  defp digit(8, x, y, _), do: [y, x, x, x]
  defp digit(9, x, _, z), do: [x, z]
end
