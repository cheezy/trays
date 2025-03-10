defmodule TraysWeb.Admin.ProductLive.Index do
  use TraysWeb, :live_view

  alias Trays.Admin.Merchants
  alias Trays.Admin.Products

  @moduledoc false

  def mount(%{"merchant_id" => merchant_id}, _session, socket) do
    merchant = Merchants.get_merchant!(merchant_id)

    assign(socket, :merchant, merchant)
    |> ok()
  end

  def handle_params(%{"merchant_id" => merchant_id}, _url, socket) do
    socket
    |> assign(:page_title, "Products for #{socket.assigns.merchant.name}")
    |> stream(:products, Products.list_products_for_merchant(merchant_id))
    |> noreply()
  end

  def render(assigns) do
    ~H"""
    <div class="products-index">
      <.header>
        {@page_title}
      </.header>
      <.table id="products" rows={@streams.products}>
        <:col :let={{_, product}}>
          <img src={product.image_path} width="60" />
        </:col>
        <:col :let={{_, product}} label={gettext("Name")}>
          {product.name}
        </:col>
        <:col :let={{_, product}} label={gettext("Category")}>
          {product.category}
        </:col>
        <:col :let={{_, product}} label={gettext("Price")}>
          {"$#{Money.to_string(product.price, symbol: false)}"}
        </:col>
        <:col :let={{_, product}}>
          <span class="veg" :if={product.vegetarian} aria-label="Vegetarian">V</span>
          <span class="vegan" :if={product.vegan} aria-label="Vegan">V</span>
          <span class="glfree" :if={product.gluten_free} aria-label="Gluten Free">GF</span>
          <span class="nutfree" :if={product.nut_free} aria-label="Nut Free">NF</span>
        </:col>
      </.table>
    </div>
    <.back navigate={~p"/#{@locale}/admin/merchants/#{@merchant}"}>
      {gettext("Back to Merchant")}
    </.back>
    """
  end
end
