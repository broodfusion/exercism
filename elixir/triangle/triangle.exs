defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) do
    # with conditions
    with :ok <- check_positive(a, b, c),
         :ok <- triangle_inequality(a, b, c) do
      cond do
        a == b && b == c && a == c ->
          {:ok, :equilateral}

        a == b || b == c || a == c ->
          {:ok, :isosceles}

        a != b && b != c && a != c ->
          {:ok, :scalene}
      end
    else
      error -> error
    end
  end

  defp check_positive(a, b, c) do
    if a > 0 && b > 0 && c > 0 do
      :ok
    else
      {:error, "all side lengths must be positive"}
    end
  end

  defp triangle_inequality(a, b, c) do
    if a + b > c && a + c > b && b + c > a do
      :ok
    else
      {:error, "side lengths violate triangle inequality"}
    end
  end
end
