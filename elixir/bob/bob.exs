defmodule Bob do
  def hey(input) do
    cond do
      # empty string or string with all whitespaces
      String.length(input) == 0 or Regex.match?(~r/^\W/, input) ->
        "Fine. Be that way!"

      # string with all caps and no numbers with ending question mark
      input == String.upcase(input) and not Regex.match?(~r/[0-9]/, input) and
          String.at(input, -1) == "?" ->
        "Calm down, I know what I'm doing!"

      # string with all caps and ending exclamation mark
      input == String.upcase(input) and String.at(input, -1) == "!" ->
        "Whoa, chill out!"

      input == String.upcase(input) and not Regex.match?(~r/[0-9]/, input) ->
        "Whoa, chill out!"

      # asking a question with ending question mark or a number with ending question mark
      Regex.match?(~r/[a-z0-9]+/, input) and String.at(input, -1) == "?" ->
        "Sure."

      # non English
      not Regex.match?(~r/^[a-z0-9]/i, input) ->
        "Whoa, chill out!"

      true ->
        "Whatever."
    end
  end
end
