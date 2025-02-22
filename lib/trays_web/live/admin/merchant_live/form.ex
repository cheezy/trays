defmodule TraysWeb.Admin.MerchantLive.Form do
  use TraysWeb, :live_view

  @moduledoc false

  alias Trays.Admin.Merchants
  alias Trays.Merchant

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
      <:hint>
        {gettext("Up to %{size} MB (.png, .jpeg, .jpg)",
          size: trunc(@uploads.logo.max_file_size / 1_000_000))
        }
      </:hint>
    </.image_upload>

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

  attr :image, Phoenix.LiveView.UploadConfig, required: true
  slot :label, required: true
  slot :hint
  
  def image_upload(assigns) do
    ~H"""
    <div id="image-upload">
      <label for={@image.ref} class="label">
        { render_slot(@label) }
      </label>
      <div class="drop" phx-drop-target={@image.ref}>
        <div>
          <img src="/images/upload.svg">
          <div>
            <label for={@image.ref}>
              <span>{gettext "Upload an image"}</span>
              <.live_file_input upload={@image} class="sr-only" />
            </label>
            <span>{gettext "or drag and drop here."}</span>
          </div>
          <p>
            { render_slot(@hint)}
          </p>
        </div>
      </div>

      <.error :for={err <- upload_errors(@image)}>
        {error_to_string(err)}
      </.error>

      <div class="entry" :for={entry <- @image.entries}>
        <.live_img_preview entry={entry}/>
        <div class="progress">
          <div class="value">
            {entry.progress}%
          </div>
          <div class="bar">
            <span style={"width: #{entry.progress}%"}></span>
          </div>
          <.error :for={err <- upload_errors(@image, entry)}>
            {error_to_string(err)}
          </.error>
        </div>
        <a phx-click="cancel-logo" phx-value-ref={entry.ref}>&times;</a>
      </div>
    </div>
    """
  end

  defp error_to_string(:too_large),
    do: "File too large."

  defp error_to_string(:too_many_files),
    do: "Too many files."

  defp error_to_string(:not_accepted),
    do: "That's not an acceptable file type."

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