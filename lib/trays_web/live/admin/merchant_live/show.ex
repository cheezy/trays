defmodule TraysWeb.Admin.MerchantLive.Show do
  use TraysWeb, :live_view

  @moduledoc false

  alias Trays.Admin.Merchants

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _url, socket) do
    merchant = Merchants.get_merchant_with_locations_and_contact!(id)

    socket
    |> assign(merchant: merchant)
    |> assign(locations: merchant.merchant_locations)
    |> assign(page_title: merchant.name)
    |> noreply()
  end

  def render(assigns) do
    ~H"""
    <div class="merchant-show">
      <div class="merchant">
        <img src={@merchant.logo_path} alt={gettext("Logo")} />
        <section>
          <header>
            <div>
              <h2>{@merchant.name}</h2>
              <h3>{@merchant.food_category}</h3>
            </div>
            <div class="contact">
              {@merchant.contact.name}<br />
              {@merchant.contact.phone_number}<br />
              {@merchant.contact.email}
            </div>
          </header>
          <div class="description">
            {@merchant.description}
          </div>
        </section>
      </div>
      <.merchant_locations merchant_id={@merchant.id} current_user={@current_user} locations={@locations} locale={@locale} />
    </div>
    <.back navigate={~p"/#{@locale}/admin/merchants"}>
      {gettext("Back to all Merchants")}
    </.back>
    """
  end

  def merchant_locations(assigns) do
    ~H"""
    <.header>
      <:actions>
        <.link
          navigate={~p"/#{@locale}/admin/merchants/#{@merchant_id}/products"}
          id="manage_products_btn"
          class="button"
        >
          {gettext("Manage Products")}
        </.link>
      </:actions>
      <:actions>
        <.link
          navigate={~p"/#{@locale}/admin/merchants/#{@merchant_id}/locations/new"}
          id="new_location_btn"
          class="button"
        >
          {gettext("New Location")}
        </.link>
      </:actions>
    </.header>
    <.table id="locations" rows={@locations}>
      <:col :let={location} label={gettext("Street")}>
        {location.street1}
      </:col>
      <:col :let={location} label={gettext("City")}>
        {location.city}
      </:col>
      <:col :let={location} label={gettext("Province")}>
        {location.province}
      </:col>
      <:col :let={location} label={gettext("Country")}>
        {location.country}
      </:col>
      <:col :let={location} label={gettext("Contact")}>
        {location.contact.name}
      </:col>
      <:action :let={location}>
        <.link
          navigate={~p"/#{@locale}/admin/merchants/#{@merchant_id}/locations/#{location.id}/edit"}
          class="edit-merchant-location"
        >
          <.icon name="hero-pencil-square" class="h-4 w-4" />
        </.link>
      </:action>
      <:action :let={location}>
        <.link
          phx-click="delete"
          phx-value-id={location.id}
          phx-disable-with={gettext("Deleting...")}
          data-confirm={gettext("Are you sure?")}
          class="delete-merchant-location"
        >
          <.icon name="hero-trash" class="h-4 w-4" />
        </.link>
      </:action>
    </.table>
    """
  end

  def handle_event("delete", %{"id" => id}, socket) do
    merchant = Merchants.get_merchant_location!(id)
    {:ok, _} = Merchants.delete_merchant_location(merchant)
    merchant = Merchants.get_merchant_with_locations_and_contact!(socket.assigns.merchant.id)

    {:noreply, assign(socket, :locations, merchant.merchant_locations)}
  end
end
