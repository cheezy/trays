defmodule TraysWeb.Admin.ModifierGroupLive.Form do
  use TraysWeb, :live_view

  @moduledoc false

  alias Trays.Admin.ModifierGroups
  alias Trays.ModifierGroup

  def mount(%{"merchant_id" => merchant_id} = params, _session, socket) do
    socket
    |> assign(:merchant_id, merchant_id)
    |> apply_action(socket.assigns.live_action, params)
    |> ok()
  end

  defp apply_action(socket, :new, _params) do
    modifier_group = %ModifierGroup{}
    changeset = ModifierGroups.change_modifier_group(modifier_group)

    socket
    |> assign(:page_title, gettext("New Modifier Group"))
    |> assign(:form, to_form(changeset))
    |> assign(:modifier_group, modifier_group)
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    modifier_group = ModifierGroups.get_modifier_group!(id)
    changeset = ModifierGroups.change_modifier_group(modifier_group)

    socket
    |> assign(:page_title, gettext("Edit Modifier Group"))
    |> assign(:form, to_form(changeset))
    |> assign(:modifier_group, modifier_group)
  end

  def render(assigns) do
    ~H"""
    <.header>
      {@page_title}
    </.header>
    <.form for={@form} id="modifier-groups-form" phx-submit="save" phx-change="validate">
      <.input field={@form[:name]} label={gettext("Name")} />
      <div class="modifier-group-min-max">
        <div class="minimum">
          <.input type="number" field={@form[:minimum]} label={gettext("Minimum")} />
        </div>
        <div class="maximum">
          <.input type="number" field={@form[:maximum]} label={gettext("Maximum")} />
        </div>
      </div>
      <div class="action">
        <.button type="submit" class="submit" phx-disable-with={gettext("Saving...")}>
          {gettext("Save Modifier Group")}
        </.button>
      </div>
    </.form>
    """
  end

  def handle_event("validate", %{"modifier_group" => modifier_group}, socket) do
    changeset = ModifierGroups.change_modifier_group(socket.assigns.modifier_group, modifier_group)

    assign(socket, :form, to_form(changeset, action: :validate))
    |> noreply()
  end

  def handle_event("save", %{"modifier_group" => modifier_group}, socket) do
    save_modifier_group(socket, socket.assigns.live_action, modifier_group)
  end

  defp save_modifier_group(socket, :new, modifier_group) do
    merchant_id = socket.assigns.merchant_id |> String.to_integer()

    ModifierGroups.create_modifier_group(merchant_id, modifier_group)
    |> handle_save_results(socket, gettext("Modifier Group created successfully!"))
  end

  defp save_modifier_group(socket, :edit, modifier_group) do
    ModifierGroups.update_modifier_group(socket.assigns.modifier_group, modifier_group)
    |> handle_save_results(socket, gettext("Modifier Group updated successfully!"))
  end

  defp handle_save_results(result, socket, message) do
    case result do
      {:ok, _modifier_group} ->
        socket
        |> put_flash(:info, message)
        |> push_navigate(
          to: ~p"/#{socket.assigns.locale}/admin/merchants/#{socket.assigns.merchant_id}/modifier_groups"
        )
        |> noreply()

      {:error, %Ecto.Changeset{} = changeset} ->
        assign(socket, :form, to_form(changeset))
        |> noreply()
    end
  end
end
