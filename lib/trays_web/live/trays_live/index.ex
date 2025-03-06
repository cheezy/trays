defmodule TraysWeb.TraysLive.Index do
  use TraysWeb, :live_view

  @moduledoc false

  alias Trays.Merchants

  def mount(_params, _session, socket) do
    assign(socket, :page_title, gettext("Trays"))
    |> ok()
  end

  def handle_params(_params, _url, socket) do
    socket
    |> stream(:merchants, Merchants.list_merchants(), reset: true)
    |> noreply()
  end

  def render(assigns) do
    ~H"""
    <div class="trays-index">
      <h1>{@page_title}</h1>

      <div id="merchants" class="merchants" phx-update="stream">
        <div id="empty" class="no-results only:block hidden">
          No merchants found. Try changing your filters.
        </div>
        <.merchant_card
          :for={{dom_id, merchant} <- @streams.merchants}
          merchant={merchant}
          id={dom_id}
          locale={@locale}
        />
      </div>
    </div>
    """
  end

  attr :merchant, Trays.Merchant, required: true
  attr :id, :string, required: true
  attr :locale, :string, required: true

  def merchant_card(assigns) do
    ~H"""
    <div class="card" id="{@id}">
      <div class="name">
        {@merchant.name}
      </div>
      <div class="content">
        <img src={@merchant.logo_path} />
        <div class="details">
          <h2>{@merchant.food_category}</h2>
          {@merchant.description}
        </div>
      </div>
    </div>
    """
  end
end
