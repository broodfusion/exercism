defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    Regex.replace(~r/[^a-zA-Z]/, sentence, "", trim: true)
    |> String.upcase()
    |> String.split("", trim: true)
    |> Enum.reduce([], fn key, acc ->
      key = String.to_atom(key)

      if !acc[key] do
        put_in(acc[key], 1)
      else
        update_in(acc[key], &(&1 + 1))
      end
    end)
    |> length() == 26
  end
end
