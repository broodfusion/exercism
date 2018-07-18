defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @vowels ["a", "e", "i", "o", "u"]
  @special_constants ["ch", "qu", "squ", "th", "thr", "sch"]

  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    # check when phrase has multiple words separated by whitespace
    case Regex.match?(~r/\s/, phrase) do
      true ->
        translate_multiple_phrases(phrase)

      false ->
        cond do
          # Some groups are treated like vowels, including "yt" and "xr".
          String.starts_with?(phrase, ["x", "y"]) &&
              !String.contains?(String.at(phrase, 1), @vowels) ->
            "#{phrase}ay"

          # if word starts with with vowels (aeiou) should have "ay" added to the end of the word.
          String.starts_with?(phrase, @vowels) ->
            "#{phrase}ay"

          # Some groups of letters are treated like consonants, including "ch", "qu",
          # "squ", "th", "thr", and "sch".
          String.starts_with?(phrase, @special_constants) ->
            translate_special_constants(phrase)

          true ->
            translate_all_other(phrase)
        end
    end
  end

  defp translate_multiple_phrases(phrase) do
    list_of_phrase = String.split(phrase, " ", trim: true)

    Enum.map(list_of_phrase, fn x -> translate(x) end)
    |> Enum.join(" ")
  end

  defp translate_special_constants(phrase) do
    [head, tail] =
      Regex.split(
        ~r{(ch)|(qu)|(squ)|(thr)|(th)|(sch)},
        phrase,
        include_captures: true,
        trim: true
      )

    "#{tail}#{head}ay"
  end

  defp translate_all_other(phrase) do
    {head, tail} =
      phrase
      |> String.split("", trim: true)
      |> Enum.split_while(fn x -> !String.contains?(x, @vowels) end)

    "#{Enum.join(tail)}#{Enum.join(head)}ay"
  end
end
