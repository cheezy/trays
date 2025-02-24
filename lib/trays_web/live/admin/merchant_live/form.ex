defmodule TraysWeb.Admin.MerchantLive.Form do
  use TraysWeb, :live_view

  @moduledoc false

  alias Trays.Admin.Merchants
  alias Trays.Merchant
  import TraysWeb.ImageUpload

  def mount(params, _session, socket) do
    socket =
      socket
      |> apply_action(socket.assigns.live_action, params)
      |> allow_upload(
            :logo,
            accept: ~w(.png .jpeg .jpg),
            max_file_size: 4_000_000,
            auto_upload: false
         )

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

    <.image_upload image={@uploads.logo}>
      <:label>Logo</:label>
      <:current_image>
        <img src={@merchant.logo_path}/>
      </:current_image>
      <:hint>
        {
          gettext("Up to %{size} MB (.png, .jpeg, .jpg)",
          size: trunc(@uploads.logo.max_file_size / 1_000_000))
        }
      </:hint>
    </.image_upload>
    
    <:actions>
      <.button phx-disable-with={gettext "Saving..."}>{gettext "Save Merchant"}</.button>
    </:actions>
  </.simple_form>
  <.back navigate={~p"/#{@locale}/admin/merchants"}>
    {gettext "Back to all Merchants"}
  </.back>
  """
  end

  def handle_event("cancel-logo", %{"ref" => ref}, socket) do
      {:noreply, cancel_upload(socket, :logo, ref)}
  end

  def handle_event("validate", %{"merchant" => merchant_params}, socket) do
    changeset = Merchants.change_merchant(socket.assigns.merchant, merchant_params)
    socket = assign(socket, :form, to_form(changeset, action: :validate))
    {:noreply, socket}
  end

  def handle_event("save", %{"merchant" => merchant_params}, socket) do
    merchant_params = Map.put(merchant_params, "logo_path", logo_path(socket))
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

  defp logo_path(socket) do
    paths =
      consume_uploaded_entries(socket, :logo, fn meta, entry ->
        dest =
          Path.join([
            "priv",
            "static",
            "uploads",
            "#{entry.uuid}-#{entry.client_name}"
          ])
        File.cp!(meta.path, dest)
        url_path = static_path(socket, "/uploads/#{Path.basename(dest)}")
        {:ok, url_path}
      end)
    List.first(paths)
  end
end