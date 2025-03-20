defmodule TraysWeb.Admin.ModifierLive.Form do
  use TraysWeb, :live_view

  alias Trays.Admin.Modifiers
  alias Trays.Modifier

  @moduledoc false

  def mount(params, _session, socket) do
    socket
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
    |> assign(:modifier_group, modifier)
  end

  def render(assigns) do
    ~H"""
    <.header>
      {@page_title}
    </.header>
    """
  end
end
