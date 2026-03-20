defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, & &1.price, :asc)
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, &(&1.price == nil))
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn product ->
      %{product | name: String.replace(product.name, old_word, new_word)}
    end)
  end

  def increase_quantity(item, count) do
    quantity_by_size =
      Map.new(item[:quantity_by_size], fn {key, value} -> {key, value + count} end)

    %{item | quantity_by_size: quantity_by_size}
  end

  def total_quantity(item) do
    item[:quantity_by_size]
    |> Enum.reduce(0, fn {_key, val}, acc -> acc + val end)
  end
end
