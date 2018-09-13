defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    _strain(list, &fun.(&1))
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    _strain(list, &(not fun.(&1)))
  end

  defp _strain([], _fun), do: []

  defp _strain([head | tail], fun) do
    if fun.(head) do
      [head | _strain(tail, fun)]
    else
      _strain(tail, fun)
    end
  end
end
