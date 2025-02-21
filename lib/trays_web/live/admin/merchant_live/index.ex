defmodule TraysWeb.Admin.MerchantLive.Index do
  use TraysWeb, :live_view

  @moduledoc false

  alias Trays.Admin.Merchants

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:page_title, gettext("Listing Merchants"))
      |> stream(:merchants, Merchants.list_merchants())

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="merchants-index">
      <.header>
        {@page_title}
        <:actions>
          <.link navigate={~p"/#{@locale}/admin/merchants/new"} id="new_merchant_btn" class="button">
            {gettext "New Merchant"}
          </.link>
        </:actions>
      </.header>
      <.table
          id="merchants"
          rows={@streams.merchants}
          row_click={fn {_, merchant} -> JS.navigate(~p"/#{@locale}/admin/merchants/#{merchant}") end}
          >
        <:col :let={{_, merchant}}>
          <img src={merchant.logo_path} width="60"/>
        </:col>
        <:col :let={{_, merchant}} label={gettext "Name"}>
          <.link navigate={~p"/#{@locale}/admin/merchants/#{merchant}"}>
            {merchant.name}
          </.link>
        </:col>
        <:col :let={{_, merchant}} label={gettext "Name"}>
          {merchant.description}
        </:col>
        <:col :let={{_, merchant}} label={gettext "Contact"}>
          {merchant.contact_name}
        </:col>
        <:col :let={{_, merchant}} label={gettext "Phone"}>
          {merchant.contact_phone}
        </:col>
        <:action :let={{_, merchant}}>
          <.link navigate={~p"/#{@locale}/admin/merchants/#{merchant}/edit"} class="edit-merchant">
            <.icon name="hero-pencil-square" class="h-4 w-4" />
          </.link>
        </:action>
        <:action :let={{dom_id, merchant}}>
          <.link
            phx-click={delete_and_hide(dom_id, merchant)}
            data-confirm={gettext "Are you sure?"}
            class="delete-merchant"
          >
            <.icon name="hero-trash" class="h-4 w-4" />
          </.link>
        </:action>
      </.table>
    </div>
    """
  end

  def handle_event("delete", %{"id" => id}, socket) do
    merchant = Merchants.get_merchant!(id)
    {:ok, _} = Merchants.delete_merchant(merchant)
    {:noreply, stream_delete(socket, :merchants, merchant)}
  end

  def delete_and_hide(dom_id, merchant) do
    JS.push("delete", value: %{id: merchant.id})
    |> JS.hide(to: "##{dom_id}", transition: "fade-out")
  end

end
