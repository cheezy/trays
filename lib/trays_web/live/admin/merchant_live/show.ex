defmodule TraysWeb.Admin.MerchantLive.Show do
  use TraysWeb, :live_view

    @moduledoc false

  alias Trays.Admin.Merchants

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _url, socket) do
    merchant = Merchants.get_merchant!(id)

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
    </div>
    <.back navigate={~p"/#{@locale}/admin/merchants"}>
      {gettext "Back to all Merchants"}
    </.back>
    """
  end

end