defmodule TraysWeb.Admin.ModifierGroupLive.Index do
  use TraysWeb, :live_view

  alias Trays.Admin.ModifierGroups

  @moduledoc false

  def mount(%{"merchant_id" => merchant_id}, _session, socket) do
    socket
    |> stream(:modifier_groups, ModifierGroups.list_modifier_groups(merchant_id))
    |> assign(:merchant_id, merchant_id)
    |> assign(:page_title, "Modifier Groups")
    |> ok()
  end

  def render(assigns) do
    ~H"""
    <div class="modifier-groups-index">
      <.header>
        {@page_title}
      </.header>
    </div>
    <.back navigate={~p"/#{@locale}/admin/merchants/#{@merchant_id}"}>
      {gettext("Back to Merchant")}
    </.back>
    <.table id="modifier_groups" rows={@streams.modifier_groups}>
      <:col :let={{_, modifier_groups}} label={gettext("Name")}>
        {modifier_groups.name}
      </:col>
      <:col :let={{_, modifier_groups}} label={gettext("Minimum")}>
        {modifier_groups.minimum}
      </:col>
      <:col :let={{_, modifier_groups}} label={gettext("Maximum")}>
        {modifier_groups.maximum}
      </:col>
    </.table>
    <.back navigate={~p"/#{@locale}/admin/merchants/#{@merchant_id}"}>
      {gettext("Back to Merchant")}
    </.back>

    """
  end
end
