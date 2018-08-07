defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("212-555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 055-0100")
  "0000000000"

  iex> Phone.number("(212) 555-0100")
  "2125550100"

  iex> Phone.number("867.5309")
  "0000000000"
  """

  @spec number(String.t()) :: String.t()
  def number(raw) do
    with {:ok, str} <- check_only_numbers(raw),
         {:ok, str} <- check_leading_1(str),
         {:ok, str} <- check_area_code(str),
         {:ok, str} <- check_exchange_code(str),
         {:ok, str} <- check_length(str) do
      str
    else
      {:error, error_msg} -> error_msg
    end
  end

  # check if only number
  defp check_only_numbers(raw) do
    if Regex.match?(~r/[a-zA-Z]/, raw) do
      error()
    else
      {:ok, String.replace(raw, ~r/\D/, "", global: true)}
    end
  end

  defp check_leading_1(str) do
    cond do
      String.length(str) == 10 ->
        {:ok, str}

      String.starts_with?(str, "1") && String.length(str) == 11 ->
        {:ok, String.slice(str, 1..-1)}

      true ->
        error()
    end
  end

  # check if area code starts with 1 or 0
  defp check_area_code(str) do
    if String.at(str, 0) == "1" || String.at(str, 0) == "0" do
      error()
    else
      {:ok, str}
    end
  end

  # check if exchange code starts with 1 or 0
  defp check_exchange_code(str) do
    if String.at(str, 3) == "1" || String.at(str, 3) == "0" do
      error()
    else
      {:ok, str}
    end
  end

  # check if final number is of length 10
  defp check_length(str) do
    if String.length(str) != 10 do
      error()
    else
      {:ok, str}
    end
  end

  # display invalid number/error
  defp error(), do: {:error, "0000000000"}

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("212-555-0100")
  "212"

  iex> Phone.area_code("+1 (212) 555-0100")
  "212"

  iex> Phone.area_code("+1 (012) 555-0100")
  "000"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t()) :: String.t()
  def area_code(raw) do
    if number(raw) == "0000000000" do
      "000"
    else
      number(raw)
      |> String.slice(0..2)
    end
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("212-555-0100")
  "(212) 555-0100"

  iex> Phone.pretty("212-155-0100")
  "(000) 000-0000"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t()) :: String.t()
  def pretty(raw) do
    if number(raw) == "0000000000" do
      "(000) 000-0000"
    else
      exchange_code = raw |> number() |> String.slice(3..5)
      subscriber_num = raw |> number() |> String.slice(6..-1)
      "(#{area_code(raw)}) #{exchange_code}-#{subscriber_num}"
    end
  end
end
