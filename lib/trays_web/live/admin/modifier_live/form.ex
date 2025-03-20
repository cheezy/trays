defmodule TraysWeb.Admin.ModifierLive.Form do
  use TraysWeb, :live_view

  alias Trays.Admin.Modifiers
  alias Trays.Modifier

  @moduledoc false

  def mount(%{"modifier_group_id" => modifier_group_id, "merchant_id" => merchant_id} = params,
            _session, socket) do
    socket
    |> assign(:modifier_group_id, modifier_group_id)
    |> assign(:merchant_id, merchant_id)
    |> apply_action(socket.assigns.live_action, params)
    |> ok()
  end

  defp apply_action(socket, :new, _params) do
    modifier = %Modifier{}
    changeset = Modifiers.change_modifier(modifier)

    socket
    |> assign(:page_title, gettext("New Modifier"))
    |> assign(:form, to_form(changeset))
    |> assign(:modifier, modifier)
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    modifier = Modifiers.get_modifier!(id)
    changeset = Modifiers.change_modifier(modifier)

    socket
    |> assign(:page_title, gettext("Edit Modifier"))
    |> assign(:form, to_form(changeset))
    |> assign(:modifier, modifier)
  end

  def render(assigns) do
    ~H"""
    <.header>
      {@page_title}
    </.header>
    <.form for={@form} id="modifier-form" phx-submit="save" phx-change="validate">
      <.input field={@form[:name]} label={gettext("Name")} />
      <div class="modifier-options">
        <.input type="checkbox" field={@form[:vegetarian]} label={gettext("Vegetarian")} />
        <.input type="checkbox" field={@form[:vegan]} label={gettext("Vegan")} />
        <.input type="checkbox" field={@form[:gluten_free]} label={gettext("Gluten Free")} />
        <.input type="checkbox" field={@form[:nut_free]} label={gettext("Nut Free")} />
      </div>
      <div class="action">
        <.button type="submit" class="submit" phx-disable-with={gettext("Saving...")}>
          {gettext("Save Modifier")}
        </.button>
      </div>
    </.form>
    """
  end

  def handle_event("validate", %{"modifier" => modifier_params}, socket) do
    changeset = Modifiers.change_modifier(socket.assigns.modifier, modifier_params)

    assign(socket, :form, to_form(changeset, action: :validate))
    |> noreply()
  end

  def handle_event("save", %{"modifier" => modifier_params}, socket) do
    save_modifier(socket, socket.assigns.live_action, modifier_params)
  end

  defp save_modifier(socket, :new, modifier_params) do
    modifier_group_id = socket.assigns.modifier_group_id |> String.to_integer()

    Modifiers.create_modifier(modifier_group_id, modifier_params)
    |> handle_save_results(socket, gettext("Modifier created successfully!"))
  end

  defp save_modifier(socket, :edit, modifier_params) do
    Modifiers.update_modifier(socket.assigns.modifier, modifier_params)
    |> handle_save_results(socket, gettext("Modifier updated successfully!"))
  end

  defp handle_save_results(result, socket, message) do
    %{merchant_id: merchant_id, modifier_group_id: modifier_group_id} = socket.assigns
    case result do
      {:ok, _modifier} ->
        socket
        |> put_flash(:info, message)
        |> push_navigate(
          to: ~p"/#{socket.assigns.locale}/admin/merchants/#{merchant_id}/modifier_groups/#{modifier_group_id}"
        )
        |> noreply()

      {:error, %Ecto.Changeset{} = changeset} ->
        assign(socket, :form, to_form(changeset))
        |> noreply()
    end
  end
end
