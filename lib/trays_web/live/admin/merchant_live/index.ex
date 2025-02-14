defmodule TraysWeb.Admin.MerchantLive.Index do
  use TraysWeb, :live_view

  @moduledoc false

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:page_title, gettext("Listing Merchants"))

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="merchants-index">
      <.header>
        {@page_title}
      </.header>
    </div>
    """
  end
end
