defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string
    |> String.graphemes()
    |> Enum.chunk_by(& &1)
    |> Enum.map(fn x ->
      if length(x) > 1 do
        char = Enum.uniq(x) |> List.to_string()
        "#{length(x)}" <> char
      else
        List.to_string(x)
      end
    end)
    |> Enum.join("")
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    Regex.replace(~r/\D/, string, "\\g{0}*", trim: true)
    |> String.split("*", trim: true)
    |> Enum.map(fn x ->
      if String.length(x) == 1 do
        x
      else
        {number, letter} = String.split_at(x, -1)
        String.duplicate(letter, String.to_integer(number))
      end
    end)
    |> Enum.join("")
  end
end
