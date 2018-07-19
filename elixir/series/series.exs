defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size) do
    cond do
      String.length(s) < size or size <= 0 ->
        []

      size == 1 ->
        String.split(s, "", trim: true)

      true ->
        s
        |> String.split("", trim: true)
        |> Enum.chunk_every(size, 1, :discard)
        |> Enum.map(fn x -> Enum.join(x, "") end)
    end
  end
end
