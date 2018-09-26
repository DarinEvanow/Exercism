defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) do
    cond do
      any_negative_sides?(a, b, c) -> {:error, "all side lengths must be positive"}
      not triangle_equality?(a, b, c) -> {:error, "side lengths violate triangle inequality"}
      all_sides_equal?(a, b, c) -> {:ok, :equilateral}
      two_sides_equal?(a, b, c) -> {:ok, :isosceles}
      true -> {:ok, :scalene}
    end
  end

  @spec any_negative_sides?(number, number, number) :: boolean
  defp any_negative_sides?(a, b, c) do
    a <= 0 or b <= 0 or c <= 0
  end

  @spec triangle_equality?(number, number, number) :: boolean
  defp triangle_equality?(a, b, c) do
    sorted_sides = Enum.sort([a, b, c])
    Enum.at(sorted_sides, 0) + Enum.at(sorted_sides, 1) > Enum.at(sorted_sides, 2)
  end

  @spec all_sides_equal?(number, number, number) :: boolean
  defp all_sides_equal?(a, b, c) do
    a == b and b == c
  end

  @spec two_sides_equal?(number, number, number) :: boolean
  defp two_sides_equal?(a, b, c) do
    a == b or a == c or b == c
  end
end
