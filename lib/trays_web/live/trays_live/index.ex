defmodule TraysWeb.TraysLive.Index do
  use TraysWeb, :live_view

  @moduledoc false

  def mount(_params, _session, socket) do
    socket = assign(socket, :page_title, gettext("Trays"))
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="trays-index">
      <h1>{@page_title}</h1>
    </div>
    """
  end
end
