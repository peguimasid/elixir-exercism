defmodule KitchenCalculator do
  def get_volume({_, volume}), do: volume

  def to_milliliter({:milliliter, volume}), do: {:milliliter, volume}
  def to_milliliter({:cup, volume}), do: {:milliliter, volume * 240}
  def to_milliliter({:fluid_ounce, volume}), do: {:milliliter, volume * 30}
  def to_milliliter({:teaspoon, volume}), do: {:milliliter, volume * 5}
  def to_milliliter({:tablespoon, volume}), do: {:milliliter, volume * 15}

  def from_milliliter({:milliliter, ml}, :milliliter), do: {:milliliter, ml}
  def from_milliliter({:milliliter, ml}, :cup), do: {:cup, ml / 240}
  def from_milliliter({:milliliter, ml}, :fluid_ounce), do: {:fluid_ounce, ml / 30}
  def from_milliliter({:milliliter, ml}, :teaspoon), do: {:teaspoon, ml / 5}
  def from_milliliter({:milliliter, ml}, :tablespoon), do: {:tablespoon, ml / 15}

  def convert(volume_pair, unit), do: from_milliliter(to_milliliter(volume_pair), unit)
end
