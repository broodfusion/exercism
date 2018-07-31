defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    Enum.filter(
      candidates,
      &(char_map(&1) == char_map(base) && String.upcase(&1) != String.upcase(base))
    )
  end

  @spec char_map(String.t()) :: Map.t()
  defp char_map(str) do
    str
    |> String.upcase()
    |> String.split("", trim: true)
    |> Enum.reduce(%{}, fn key, acc ->
      key = String.to_atom(key)

      if !acc[key] do
        put_in(acc[key], 1)
      else
        update_in(acc[key], &(&1 + 1))
      end
    end)
  end
end
