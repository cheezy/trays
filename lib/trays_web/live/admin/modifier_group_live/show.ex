defmodule TraysWeb.Admin.ModifierGroupLive.Show do
  use TraysWeb, :live_view

  alias Trays.Admin.ModifierGroups

  @moduledoc false

  def mount(%{"id" => id, "merchant_id" => merchant_id}, _session, socket) do
    modifier_group = ModifierGroups.get_modifier_group_with_modifiers!(id)
    
    socket
    |> assign(:merchant_id, merchant_id)
    |> assign(:modifier_group, modifier_group)
    |> assign(:page_title, "Modifier Group")
    |> ok()
  end

  def render(assigns) do
    ~H"""
    <div class="modifier-group-show">
      <div class="modifier-group">
        <section>
          <header>
            <div>
              <h2>{@modifier_group.name}</h2>
              <h3>Minimum modifiers: {@modifier_group.minimum}</h3>
              <h3>Maximum modifiers: {@modifier_group.maximum}</h3>
            </div>
          </header>
        </section>
      </div>
      <.modifiers
        modifiers={@modifier_group.modifiers}
        merchant_id={@merchant_id}
        locale={@locale}
      />
    </div>
    <.back navigate={~p"/#{@locale}/admin/merchants/#{@merchant_id}/modifier_groups"}>
      {gettext("Back to all Modifier Groups")}
    </.back>
    """
  end

  def modifiers(assigns) do
    ~H"""
    <.header>
      <:actions>
        <.link
          navigate={~p"/#{@locale}/admin/merchants/#{@merchant_id}/modifier_groups"}
          id="add_modifier_btn"
          class="button"
        >
          {gettext("Add Modifier")}
        </.link>
      </:actions>
    </.header>
    <.table id="modifiers" rows={@modifiers}>
      <:col :let={modifier} label={gettext("Name")}>
        {modifier.name}
      </:col>
      <:col :let={modifier} label={gettext("Vegetarian")}>
        {modifier.vegetarian}
      </:col>
      <:col :let={modifier} label={gettext("Vegan")}>
        {modifier.vegan}
      </:col>
      <:col :let={modifier} label={gettext("Gluten Free")}>
        {modifier.gluten_free}
      </:col>
      <:col :let={modifier} label={gettext("Nut Free")}>
        {modifier.nut_free}
      </:col>
    </.table>
    """
  end
end
