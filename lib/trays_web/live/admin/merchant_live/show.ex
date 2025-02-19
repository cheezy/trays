defmodule TraysWeb.Admin.MerchantLive.Show do
  use TraysWeb, :live_view

    @moduledoc false

  alias Trays.Admin.Merchants

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _url, socket) do
    merchant = Merchants.get_merchant_with_locations!(id)

    socket =
      socket
      |> assign(merchant: merchant)
      |> assign(page_title: merchant.name)

    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="merchant-show">
      <div class="merchant">
        <img src={@merchant.logo_path} alt={gettext "Logo"} />
        <section>
          <header>
            <div>
              <h2>{@merchant.name}</h2>
              <h3>{@merchant.food_category}</h3>
            </div>
            <div class="contact">
              {@merchant.contact_name}<br>
              {@merchant.contact_phone}<br>
              {@merchant.contact_email}
            </div>
          </header>
          <div class="description">
            {@merchant.description}
          </div>
          <img src={@merchant.store_image_path} />
        </section>
      </div>
      <.header>
        <:actions>
          <.link navigate={~p"/#{@locale}/admin/merchants/#{@merchant.id}/locations/new"} id="new_merchant_btn" class="button">
            {gettext "New Location"}
          </.link>
        </:actions>
      </.header>
      <.table
          id="locations"
          rows={@merchant.merchant_locations}
          row_click={fn location -> JS.navigate(~p"/#{@locale}/admin/merchants/") end}
        >
        <:col :let={location} label={gettext "Street"}>
          {location.street1}
        </:col>
        <:col :let={location} label={gettext "City"}>
          {location.city}
        </:col>
        <:col :let={location} label={gettext "Province"}>
          {location.province}
        </:col>
        <:col :let={location} label={gettext "Country"}>
          {location.country}
        </:col>
        <:col :let={location} label={gettext "Contact"}>
          {location.contact_name}
        </:col>
        <:action :let={location}>
          <.link
              navigate={~p"/#{@locale}/admin/merchants/#{@merchant.id}/locations/#{location.id}/edit"}
              class="edit-merchant-location"
          >
            <.icon name="hero-pencil-square" class="h-4 w-4" />
          </.link>
        </:action>
      </.table>
    </div>
    <.back navigate={~p"/#{@locale}/admin/merchants"}>
      {gettext "Back to all Merchants"}
    </.back>
    """
  end

end