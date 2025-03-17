alias Trays.Repo
alias Trays.Merchant
alias Trays.ModifierGroup
alias Trays.ProductModifier
alias Trays.Admin.Products
import Ecto.Query

defmodule ProductModifiersSeed do
  @moduledoc false

  def create_product_modifier(product_name, modifier_name) do
    create_product_modifier = fn product, modifier ->
        %ProductModifier{
          price: Money.new(0),
          product_id: product.id,
          modifier_id: modifier.id
        }
        |> Repo.insert!()
      end

    product =
      apd()
      |> get_products()
      |> get_product_by_name(product_name)

    modifier_group =
      apd()
      |> get_modifier_groups()
      |> get_modifier_group_by_name(modifier_name)

    Enum.each(modifier_group.modifiers, fn mod -> create_product_modifier.(product, mod) end)
  end

  defp get_product_by_name(products, name) do
    Enum.find(products, fn prod -> prod.name == name end)
  end

  defp get_modifier_group_by_name(modifiers, name) do
    Enum.find(modifiers, fn mod -> mod.name == name end)
  end

  defp get_modifier_groups(merchant) do
    ModifierGroup
    |> where(merchant_id: ^merchant.id)
    |> Repo.all()
    |> Repo.preload(:modifiers)
  end

  defp get_products(merchant) do
    Products.list_products_for_merchant(merchant.id)
  end

  defp apd() do
    Repo.get!(Merchant, 1)
  end
end

ProductModifiersSeed.create_product_modifier("Breakfast Sandwich Platter", "Breakfast Sandwich")
ProductModifiersSeed.create_product_modifier("Baked Good Platter", "Baked Goods")
ProductModifiersSeed.create_product_modifier("Muffin Platter", "Muffins")
ProductModifiersSeed.create_product_modifier("Mini Baked Good Platter", "Mini Baked Goods")
ProductModifiersSeed.create_product_modifier("Sandwich Platter", "Sandwiches")
ProductModifiersSeed.create_product_modifier("Side Salads", "Salads")