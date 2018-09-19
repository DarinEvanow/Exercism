defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  # Refactor: Spread out nested function calls into pipes, changed map and join into a map_join,
  # call new versions of the process function, and replace patch with replace_md
  @spec parse(String.t) :: String.t
  def parse(markdown) do
    markdown
    |> String.split("\n")
    |> Enum.map_join(fn line -> process(line) end)
    |> replace_markdown
  end

  # Refactor: Created new versions of process function that are called based on the markdown
  # element that begins the line split from the parse function
  @spec process(String.t) :: String.t
  defp process(line = "#" <> rest), do: parse_header(line)
  defp process("* " <> rest), do: "<li>#{rest}</li>"
  defp process(line), do: "<p>#{line}</p>"

  # Refactor: Created new function to parse the header type of markdown
  @spec process(String.t) :: String.t
  defp parse_header(header) do
    [ h | t ] = String.split(header, " ", parts: 2)
    "<h#{String.length(h)}>#{t}</h#{String.length(h)}>"
  end

  # Refactor: Created easier regex to help parse out the different markdown types
  @spec process(String.t) :: String.t
  defp replace_markdown(markdown) do
    markdown
    |> String.replace(~r/__(.*?)__/, "<strong>\\1</strong>")
    |> String.replace(~r/_(.*?)_/, "<em>\\1</em>")
    |> String.replace(~r/<li>.*<\/li>/, "<ul>\\0</ul>")
  end
end
