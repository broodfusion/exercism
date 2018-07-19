defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    Regex.replace(~r/\B([a-z](?=[A-Z]))/, string, "\\g{0} ", trim: true, global: true)
    |> String.split(~r/(-)|(,)|\s/, trim: true)
    |> Enum.map(fn x -> String.slice(x, 0, 1) end)
    |> Enum.join("")
    |> String.upcase()
  end
end
