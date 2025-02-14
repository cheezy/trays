defmodule TraysWeb.TraysLive.Index do
  use TraysWeb, :live_view

  @moduledoc false

  def mount(_params, _session, socket) do
    socket = assign(socket, :page_title, "Trays")
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    {@page_title}
    """
  end
end
