defmodule TraysWeb.Admin.MerchantLive.Form do
  use TraysWeb, :live_view

  @moduledoc false

  alias Trays.Admin.Merchants
  alias Trays.Merchant

  def mount(params, _session, socket) do
    socket =
      socket
      |> apply_action(socket.assigns.live_action, params)

    {:ok, socket}
  end

  defp apply_action(socket, :new, _params) do
    merchant = %Merchant{}
    changeset = Merchants.change_merchant(merchant)

    socket
    |> assign(:page_title, gettext "New Merchant")
    |> assign(:form, to_form(changeset))
    |> assign(:merchant, merchant)
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    merchant = Merchants.get_merchant!(id)
    changeset = Merchants.change_merchant(merchant)

    socket
    |> assign(:page_title, gettext "Edit Merchant")
    |> assign(:form, to_form(changeset))
    |> assign(:merchant, merchant)
  end

  def render(assigns) do
  ~H"""
  <.header>
    {@page_title}
  </.header>
  <.simple_form for={@form} id="merchant-form" phx-submit="save" phx-change="validate">
    <.input field={@form[:name]} label={gettext "Name"} />
    <.input field={@form[:food_category]} label={gettext "Category"} />
    <.input field={@form[:description]} type="textarea" label={gettext "Description"} phx-debounce="blur" />
    <.input field={@form[:logo_path]} label={gettext "Logo path"} />
    <.input field={@form[:store_image_path]} label={gettext "Store image path"} />
    <:actions>
      <.button phx-disable-with={gettext "Saving..."}>{gettext "Save Merchant"}</.button>
    </:actions>
  </.simple_form>
  <.back navigate={~p"/#{@locale}/admin/merchants"}>
    {gettext "Back to all Merchants"}
  </.back>
  """
  end

  def handle_event("validate", %{"merchant" => merchant_params}, socket) do
    changeset = Merchants.change_merchant(socket.assigns.merchant, merchant_params)
    socket = assign(socket, :form, to_form(changeset, action: :validate))
    {:noreply, socket}
  end

  def handle_event("save", %{"merchant" => merchant_params}, socket) do
    save_merchant(socket, socket.assigns.live_action, merchant_params)
  end

  defp save_merchant(socket, :new, merchant_params) do
    Merchants.create_merchant(merchant_params)
    |> handle_save_results(socket, gettext "Merchant created successfully!")
  end

  defp save_merchant(socket, :edit, merchant_params) do
    Merchants.update_merchant(socket.assigns.merchant, merchant_params)
    |> handle_save_results(socket, gettext "Merchant updated successfully!")
  end

  defp handle_save_results(result, socket, message) do
    case result do
      {:ok, _merchant} ->
        socket =
          socket
          |> put_flash(:info, message)
          |> push_navigate(to: ~p"/#{socket.assigns.locale}/admin/merchants")

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        socket = assign(socket, :form, to_form(changeset))
        {:noreply, socket}
    end
  end
end