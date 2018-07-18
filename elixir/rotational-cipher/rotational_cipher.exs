defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    String.split(text, "", trim: true)
    |> Enum.map(fn x ->
      <<codepoint::utf8>> = x

      # if uppercase
      cond do
        codepoint >= 65 && codepoint <= 90 ->
          if codepoint + shift > 90 do
            codepoint + shift - 26
          else
            codepoint + shift
          end

        # if lowercase
        codepoint >= 97 && codepoint <= 122 ->
          if codepoint + shift > 122 do
            codepoint + shift - 26
          else
            codepoint + shift
          end

        # any other nonalphabetical characters
        true ->
          codepoint
      end
    end)
    |> List.to_string()
  end
end
