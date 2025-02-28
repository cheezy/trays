defmodule TraysWeb.Admin.ProductLive.Index do
  use TraysWeb, :live_view

  alias Trays.Admin.Merchants
  alias Trays.Admin.Products

  @moduledoc false

  def mount(%{"merchant_id" => merchant_id}, _session, socket) do
    merchant = Merchants.get_merchant!(merchant_id)
    socket = assign(socket, :merchant, merchant)
    {:ok, socket}
  end

  def handle_params(%{"merchant_id" => merchant_id}, _url, socket) do
    socket =
      socket
      |> assign(:page_title, "Products for #{socket.assigns.merchant.name}")
      |> stream(:products, Products.list_products_for_merchant(merchant_id))

    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="products-index">
      <.header>
        {@page_title}
      </.header>
      <.table
        id="products"
        rows={@streams.products}
      >
        <:col :let={{_, product}}>
          <img src={product.image_path} width="60"/>
        </:col>
        <:col :let={{_, product}} label={gettext "Name"}>
          {product.name}
        </:col>
        <:col :let={{_, product}} label={gettext "Category"}>
          {product.category}
        </:col>
        <:col :let={{_, product}} label={gettext "Price"}>
          {"$#{Money.to_string(product.price, symbol: false)}"}
        </:col>
      </.table>
    </div>
    <.back navigate={~p"/#{@locale}/admin/merchants/#{@merchant}"}>
      {gettext "Back to Merchant"}
    </.back>

    """
  end
end
