defmodule TraysWeb.Admin.MerchantLocationLive.Form do
  use TraysWeb, :live_view

  @moduledoc false

  alias Trays.Admin.MerchantLocations
  alias Trays.MerchantLocation

  def mount(params, _session, socket) do
    socket
    |> apply_action(socket.assigns.live_action, params)
    |> assign(:province_options, MerchantLocations.get_provinces())
    |> ok()
  end

  defp apply_action(socket, :new, %{"merchant_id" => merchant_id}) do
    location = %MerchantLocation{}
    changeset = MerchantLocations.change_merchant_location(location)

    socket
    |> assign(:page_title, gettext("New Merchant Location"))
    |> assign(:form, to_form(changeset))
    |> assign(:location, location)
    |> assign(:merchant_id, merchant_id)
  end

  defp apply_action(socket, :edit, %{"id" => id, "merchant_id" => merchant_id}) do
    location = MerchantLocations.get_merchant_location_with_merchant!(id)
    changeset = MerchantLocations.change_merchant_location(location)

    socket
    |> assign(:page_title, gettext("Edit Merchant Location"))
    |> assign(:form, to_form(changeset))
    |> assign(:location, location)
    |> assign(:merchant_id, merchant_id)
  end

  def render(assigns) do
    ~H"""
    <.header>
      {@page_title}
    </.header>
    <.form for={@form} id="merchant-location-form" phx-submit="save" phx-change="validate">
      <div class="street">
        <.input field={@form[:street1]} label={gettext("Street")} />
        <.input field={@form[:street2]} />
      </div>
      <div class="city-province-postal">
        <div class="city">
          <.input field={@form[:city]} label={gettext("City")} />
        </div>
        <.input
          field={@form[:province]}
          type="select"
          label={gettext("Province")}
          prompt="Choose..."
          options={@province_options}
        />
        <.input field={@form[:postal_code]} label={gettext("Postal Code")} />
      </div>
      <div class="country">
        <.input field={@form[:country]} label={gettext("Country")} />
      </div>
      <div class="prep-time-delivery">
        <div class="prep-time">
          <.input field={@form[:prep_time]} type="number" label={gettext("Prep Time")} />
        </div>
        <.radio_group field={@form[:delivery_option]} label="Delivery Options">
          <:radio value="pickup">Pickup</:radio>
          <:radio value="delivery">Delivery</:radio>
          <:radio value="both">Both</:radio>
      </.radio_group>
      </div>
      <div class="action">
        <.button type="submit" class="submit" phx-disable-with={gettext("Saving...")}>
          {gettext("Save Merchant Location")}
        </.button>
      </div>
    </.form>
    <.back navigate={~p"/#{@locale}/admin/merchants/#{@merchant_id}"}>
      {gettext("Back to Merchant")}
    </.back>
    """
  end

  def handle_event("validate", %{"merchant_location" => location_params}, socket) do
    changeset = MerchantLocations.change_merchant_location(socket.assigns.location, location_params)

    assign(socket, :form, to_form(changeset, action: :validate))
    |> noreply()
  end

  def handle_event("save", %{"merchant_location" => location_params}, socket) do
    contact = socket.assigns.current_user
    location_params = Map.put(location_params, "contact_id", contact.id)
    save_merchant(socket, socket.assigns.live_action, location_params)
  end

  defp save_merchant(socket, :new, location_params) do
    merchant_id = socket.assigns.merchant_id |> String.to_integer()

    MerchantLocations.create_merchant_location(merchant_id, location_params)
    |> handle_save_results(socket, gettext("Merchant Location created successfully!"))
  end

  defp save_merchant(socket, :edit, location_params) do
    MerchantLocations.update_merchant_location(socket.assigns.location, location_params)
    |> handle_save_results(socket, gettext("Merchant Location updated successfully!"))
  end

  defp handle_save_results(result, socket, message) do
    case result do
      {:ok, location} ->
        socket
        |> put_flash(:info, message)
        |> push_navigate(
          to: ~p"/#{socket.assigns.locale}/admin/merchants/#{location.merchant_id}"
        )
        |> noreply()

      {:error, %Ecto.Changeset{} = changeset} ->
        assign(socket, :form, to_form(changeset))
        |> noreply()
    end
  end
end
