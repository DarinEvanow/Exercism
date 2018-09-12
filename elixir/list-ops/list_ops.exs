defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count([]) do 0 end
  def count([h|t]) do 1 + count(t) end

  @spec reverse(list) :: list
  def reverse(l) do reverse(l, []) end
  def reverse([], acc) do acc end
  def reverse([h|t], acc) do reverse(t, [h|acc]) end

  @spec map(list, (any -> any)) :: list
  def map([], f) do [] end
  def map([h|t], f) do [f.(h) | map(t, f)] end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], f) do [] end
  def filter([h|t], f) do
    if (f.(h)) do [h|filter(t, f)] else filter(t, f) end
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([h|t], f) do reduce(t, h, f) end
  def reduce([], acc, f) do acc end
  def reduce([h|t], acc, f) do reduce(t, f.(h, acc), f) end

  @spec append(list, list) :: list
  def append([], []) do [] end
  def append(a, []) do a end
  def append([], b) do b end
  def append([h|t], l2) do [h|append(t, l2)] end

  @spec concat([[any]]) :: [any]
  def concat([]) do [] end
  def concat([h|t]) do append(h, concat(t)) end
end
