defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    String.upcase(word)
    |> String.split("", trim: true)
    |> Enum.reduce(0, fn x, acc ->
      cond do
        x in ["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"] ->
          acc + 1

        x in ["D", "G"] ->
          acc + 2

        x in ["B", "C", "M", "P"] ->
          acc + 3

        x in ["F", "H", "V", "W", "Y"] ->
          acc + 4

        x in ["K"] ->
          acc + 5

        x in ["J", "X"] ->
          acc + 8

        x in ["Q", "Z"] ->
          acc + 10

        true ->
          acc
      end
    end)
  end
end
