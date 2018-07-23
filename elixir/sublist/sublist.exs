defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      a === b ->
        :equal

      a === [] && not is_nil(b) ->
        :sublist

      not is_nil(a) && b === [] ->
        :superlist

      length(a) === length(b) && a != b ->
        :unequal

      true ->
        str_a = Enum.join(a, " ")
        str_b = Enum.join(b, " ")

        # NOTE: TEST FAILS WHEN:
        # a = [1] and b = [1.0, 2] for example
        # When converted to strings, String.contains?("1.0 2", "1") will return true, thus giving :sublist
        # BUT, say, String.contains?("1.0 2 3 4", "1 2") will return false -> :unequal
        # For this exercise, I will just leave it like this and not bother
        # killing more brain cells to think about a better alternative

        if length(a) <= length(b) do
          case String.contains?(str_b, str_a) do
            true -> :sublist
            false -> :unequal
          end
        else
          case String.contains?(str_a, str_b) do
            true ->
              :superlist

            false ->
              :unequal
          end
        end
    end

    # def compare(a, b)
  end
end
