defmodule BirdCount do
  def today(list), do: list |> Enum.at(0)

  def increment_day_count([]), do: [1]
  def increment_day_count([head | tail]), do: [head + 1 | tail]

  def has_day_without_birds?([]), do: false
  def has_day_without_birds?(list), do: Enum.any?(list, &(&1 == 0))

  def total(list), do: Enum.sum(list)

  def busy_days(list), do: Enum.count(list, &(&1 >= 5))
end
