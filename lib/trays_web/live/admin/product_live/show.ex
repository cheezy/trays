defmodule TraysWeb.Admin.ProductLive.Show do
  use TraysWeb, :live_view

  alias Trays.Admin.Products

  @moduledoc false

  def mount(%{"id" => id, "merchant_id" => merchant_id}, _session, socket) do
    product = Products.get_product_with_product_modifiers!(id)

    socket
    |> assign(:merchant_id, merchant_id)
    |> assign(:modifier_groups, modifier_groups_for(product.product_modifiers))
    |> assign(:product, product)
    |> assign(:page_title, "#{product.name}")
    |> ok()
  end
  
  def render(assigns) do
    ~H"""
    <div class="product-show">
      <div class="product">
        <section>
          <header>
            <div>
              <h2>{@product.name}</h2>
              <h3>{"$#{Money.to_string(@product.price, symbol: false)}"}</h3>
              <span class="veg" :if={@product.vegetarian} aria-label="Vegetarian">V</span>
              <span class="vegan" :if={@product.vegan} aria-label="Vegan">V</span>
              <span class="glfree" :if={@product.gluten_free} aria-label="Gluten Free">GF</span>
              <span class="nutfree" :if={@product.nut_free} aria-label="Nut Free">NF</span>
            </div>
          </header>
        </section>
      </div>
      <.product_modifier :for={mod_group <- Map.keys(@modifier_groups)}
        modifier_group={mod_group} product_modifiers={Map.get(@modifier_groups, mod_group)}
      />

    </div>
    <.back navigate={~p"/#{@locale}/admin/merchants/#{@merchant_id}/products"}>
      {gettext("Back to all Products")}
    </.back>
    """
  end

  def product_modifier(assigns) do
    ~H"""
    <hr />
    <div class="product-modifier">
      <h3>{@modifier_group.name} Modifier</h3>
      <h3>Min: {@modifier_group.minimum} Max: {@modifier_group.maximum}</h3>
      <.table id="modifiers" rows={@product_modifiers}>
        <:col :let={product_modifier} label={gettext("Name")}>
          {product_modifier.modifier.name}
        </:col>
        <:col :let={product_modifier} label={gettext("Price")}>
          {"$#{Money.to_string(product_modifier.price, symbol: false)}"}
        </:col>
        <:col :let={product_modifier}>
          <span class="veg" :if={product_modifier.modifier.vegetarian} aria-label="Vegetarian">V</span>
          <span class="vegan" :if={product_modifier.modifier.vegan} aria-label="Vegan">V</span>
          <span class="glfree" :if={product_modifier.modifier.gluten_free} aria-label="Gluten Free">GF</span>
          <span class="nutfree" :if={product_modifier.modifier.nut_free} aria-label="Nut Free">NF</span>
        </:col>
      </.table>
    </div>
    """
  end

  defp modifier_groups_for(product_modifiers) do
    modifier_groups =
      product_modifiers
      |> Enum.map(fn prod_mod -> prod_mod.modifier.modifier_group end)
      |> Enum.uniq

    modifier_groups
    |> Enum.reduce(%{}, fn mod_group, acc ->
          Map.put(acc, mod_group, product_modifiers_for(mod_group, product_modifiers))
        end
       )
  end

  defp product_modifiers_for(group_modifier, product_modifiers) do
    product_modifiers
    |> Enum.filter(fn pm -> pm.modifier.modifier_group.id == group_modifier.id end)
  end
end
