defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  # Refactor: Spread out nested function calls into pipes
  @spec parse(String.t()) :: String.t()
  def parse(markdown) do
    markdown
    |> String.split("\n")
    |> Enum.map(fn t -> process(t) end)
    |> Enum.join
    |> patch
  end

  # Refactor: Changed nested if logic into cond
  defp process(t) do
    cond do
      String.starts_with?(t, "#") -> enclose_with_header_tag(parse_header_md_level(t))
      String.starts_with?(t, "*") -> parse_list_md_level(t)
      true -> enclose_with_paragraph_tag(String.split(t))
    end
  end

  defp parse_header_md_level(header) do
    [h | t] = String.split(header)
    {to_string(String.length(h)), Enum.join(t, " ")}
  end

  # Refactor: Piped out functions, and broke string concatenation into enclose_with_last_tag
  defp parse_list_md_level(list) do
    String.trim_leading(list, "* ")
    |> String.split
    |> join_words_with_tags
    |> enclose_with_list_tag
  end

  # Refactor: Additionally added helper method
  defp enclose_with_list_tag(text) do
    "<li>#{text}</li>"
  end

  # Refactor: combination of string interpolation and concatenation to increase readability
  defp enclose_with_header_tag({hl, htl}) do
    "<h#{hl}>" <> "#{htl}" <> "</h#{hl}>"
  end

  defp enclose_with_paragraph_tag(text) do
    "<p>#{join_words_with_tags(text)}</p>"
  end

  defp join_words_with_tags(text) do
    Enum.map(text, fn word -> replace_md_with_tag(word) end)
    |> Enum.join(" ")
  end

  defp replace_md_with_tag(markdown) do
    markdown
    |> replace_prefix_md
    |> replace_suffix_md
  end

  defp replace_prefix_md(word) do
    cond do
      word =~ ~r/^#{"__"}{1}/ -> String.replace(word, ~r/^#{"__"}{1}/, "<strong>", global: false)
      word =~ ~r/^[#{"_"}{1}][^#{"_"}+]/ -> String.replace(word, ~r/_/, "<em>", global: false)
      true -> word
    end
  end

  defp replace_suffix_md(word) do
    cond do
      word =~ ~r/#{"__"}{1}$/ -> String.replace(word, ~r/#{"__"}{1}$/, "</strong>")
      word =~ ~r/[^#{"_"}{1}]/ -> String.replace(word, ~r/_/, "</em>")
      true -> word
    end
  end

  # Refactor: used piping and removed unneeded concatenation operators
  defp patch(markdown) do
    markdown
    |> String.replace("<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>", "</li></ul>")
  end
end
