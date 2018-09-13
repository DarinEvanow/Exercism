defmodule TwelveDays do
  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    number_word = %{
      1 => "first",
      2 => "second",
      3 => "third",
      4 => "fourth",
      5 => "fifth",
      6 => "sixth",
      7 => "seventh",
      8 => "eighth",
      9 => "ninth",
      10 => "tenth",
      11 => "eleventh",
      12 => "twelfth"
    }

    gifts_list = [
      "a Partridge in a Pear Tree",
      "two Turtle Doves",
      "three French Hens",
      "four Calling Birds",
      "five Gold Rings",
      "six Geese-a-Laying"
    ]

    gifts_string = gifts_list
     |> Enum.reverse
     |> Enum.take number
     |> Enum.reduce("", fn value, acc -> acc <> ", " <> value end)

    "On the #{number_word[number]} day of Christmas my true love gave to me#{gifts_string}."
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
  end
end
