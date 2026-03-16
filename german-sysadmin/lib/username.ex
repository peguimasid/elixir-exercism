defmodule Username do
  def sanitize(username) do
    username
    |> remove_non_allowed_chars()
    |> replace_german_chars()
  end

  defp remove_non_allowed_chars(charlist) do
    charlist
    |> Enum.filter(&allowed_char?/1)
  end

  defp allowed_char?(char) when char in ?a..?z, do: true
  defp allowed_char?(char) when char in [?ä, ?ö, ?ü, ?ß, ?_], do: true
  defp allowed_char?(_char), do: false

  defp replace_german_chars(charlist) do
    charlist
    |> Enum.flat_map(&replace_german_char/1)
  end

  defp replace_german_char(char) do
    case char do
      ?ö -> ~c"oe"
      ?ä -> ~c"ae"
      ?ü -> ~c"ue"
      ?ß -> ~c"ss"
      _ -> [char]
    end
  end
end
