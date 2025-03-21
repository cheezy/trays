defmodule Trays.ProductModifierFixtures do
  @moduledoc false

  alias Trays.Repo
  alias Trays.ProductModifier

  def valid_price(), do: Money.new(12, :CAD)

  def valid_product_modifier_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      price: valid_price(),
      modifier_id: 3,
      product_id: 4
    })
  end

  def product_modifier_fixture(product, modifier, price \\ valid_price()) do
    attrs = %{product_id: product.id, modifier_id: modifier.id, price: price}
    {:ok, product_modifier} =
      %ProductModifier{}
      |> ProductModifier.changeset(valid_product_modifier_attributes(attrs))
      |> Repo.insert()

    product_modifier
  end
end
