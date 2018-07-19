defmodule TwelveDays do
  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    # case number do
    if number == 1 do
      "On the first day of Christmas my true love gave to me, a Partridge in a Pear Tree."
    else
      "On the #{get_day_in_text(number)} day of Christmas my true love gave to me, #{
        get_verse(number)
      }"
    end
  end

  defp get_verse(num) do
    gifts = [
      "and a Partridge in a Pear Tree.",
      "two Turtle Doves",
      "three French Hens",
      "four Calling Birds",
      "five Gold Rings",
      "six Geese-a-Laying",
      "seven Swans-a-Swimming",
      "eight Maids-a-Milking",
      "nine Ladies Dancing",
      "ten Lords-a-Leaping",
      "eleven Pipers Piping",
      "twelve Drummers Drumming"
    ]

    Enum.reduce_while(gifts, [], fn x, acc ->
      if length(acc) < num do
        {:cont, [x | acc]}
      else
        {:halt, acc}
      end
    end)
    |> Enum.join(", ")
  end

  defp get_day_in_text(number) do
    case number do
      2 -> "second"
      3 -> "third"
      4 -> "fourth"
      5 -> "fifth"
      6 -> "sixth"
      7 -> "seventh"
      8 -> "eighth"
      9 -> "ninth"
      10 -> "tenth"
      11 -> "eleventh"
      12 -> "twelfth"
    end
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    range = Range.new(starting_verse, ending_verse)
    Enum.map(range, fn x -> verse(x) end) |> Enum.join("\n")
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1, 12)
  end
end
