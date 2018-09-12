defmodule Bob do
  def upcase?(input) do
    input == String.upcase(input)
  end

  def hey(input) do
    cond do
      String.trim(input) == "" -> "Fine. Be that way!"
      String.ends_with?(input, "!") && upcase?(input) -> "Whoa, chill out!"
      String.ends_with?(input, "?") && upcase?(input) && String.match?(input, ~r/^([^0-9]*)$/)-> "Calm down, I know what I'm doing!"
      String.ends_with?(input, "?") -> "Sure."
      String.match?(input, ~r/^([0-9].*)$/) -> "Whatever."
      upcase?(input) -> "Whoa, chill out!"
      input -> "Whatever."
    end
  end
end
