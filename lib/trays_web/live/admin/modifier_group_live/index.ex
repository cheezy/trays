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
        <:actions>
          <.link navigate={~p"/#{@locale}/admin/merchants/#{@merchant_id}/modifier_groups/new"}
              id="new_modifier_group_btn" class="button">
            {gettext("New Modifier Group")}
          </.link>
        </:actions>
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
      <:action :let={{_, modifier_groups}}>
        <.link
          navigate={~p"/#{@locale}/admin/merchants/#{@merchant_id}/modifier_groups/#{modifier_groups.id}/edit"}
          class="edit-modifier-group"
        >
          <.icon name="hero-pencil-square" class="h-4 w-4" />
        </.link>
      </:action>
      <:action :let={{_, modifier_groups}}>
        <.link
          phx-click="delete"
          phx-value-id={modifier_groups.id}
          phx-disable-with={gettext("Deleting...")}
          data-confirm={gettext("Are you sure?")}
          class="delete-modifier-group"
        >
          <.icon name="hero-trash" class="h-4 w-4" />
        </.link>
      </:action>
    </.table>
    <.back navigate={~p"/#{@locale}/admin/merchants/#{@merchant_id}"}>
      {gettext("Back to Merchant")}
    </.back>

    """
  end

  def handle_event("delete", %{"id" => id}, socket) do
    modifier_group = ModifierGroups.get_modifier_group!(id)
    {:ok, _} = ModifierGroups.delete_modifier_group(modifier_group)
    {:noreply, stream_delete(socket, :modifier_groups, modifier_group)}
  end
end
