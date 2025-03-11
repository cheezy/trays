defmodule TraysWeb.Admin.ProductLive.Form do
  use TraysWeb, :live_view

  @moduledoc false

  alias Trays.Admin.Products
  alias Trays.Product
  import TraysWeb.ImageUpload

  def mount(%{"merchant_id" => merchant_id} = params, _session, socket) do
    socket
    |> assign(:merchant_id, merchant_id)
    |> assign(:category_suggestions, [])
    |> apply_action(socket.assigns.live_action, params)
    |> allow_upload(
      :logo,
      accept: ~w(.png .jpeg .jpg),
      max_file_size: 4_000_000,
      auto_upload: false
    )
    |> ok()
  end

  defp apply_action(socket, :new, _params) do
    product = %Product{}
    changeset = Products.change_product(product)

    socket
    |> assign(:page_title, gettext("New Product"))
    |> assign(:form, to_form(changeset))
    |> assign(:product, product)
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    product = Products.get_product!(id)
    changeset = Products.change_product(product)

    socket
    |> assign(:page_title, gettext("Edit Products"))
    |> assign(:form, to_form(changeset))
    |> assign(:product, product)
  end

  def render(assigns) do
    ~H"""
    <.header>
      {@page_title}
    </.header>
    <.form for={@form} id="product-form" phx-submit="save" phx-change="validate">
      <.input field={@form[:name]} label={gettext("Name")} />
      <.input field={@form[:category]} label={gettext("Category")}
          phx-change="suggest" list="category_suggestions" id="category"/>
      <.input
        field={@form[:description]}
        type="textarea"
        label={gettext("Description")}
        phx-debounce="blur"
      />
      <.image_upload image={@uploads.logo}>
        <:label>Product Image</:label>
        <:current_image>
          <img src={@product.image_path} />
        </:current_image>
        <:hint>
          {gettext("Up to %{size} MB (.png, .jpeg, .jpg)",
            size: trunc(@uploads.logo.max_file_size / 1_000_000)
          )}
        </:hint>
      </.image_upload>
      <.input field={@form[:price]} label={gettext "Price"}/>

      <div class="product_indicators">
        <.input field={@form[:gluten_free]} type="checkbox" label={gettext "Gluten Free"}/>
        <.input field={@form[:vegan]} type="checkbox" label={gettext "Vegan"}/>
        <.input field={@form[:vegetarian]} type="checkbox" label={gettext "Vegetarian"}/>
        <.input field={@form[:nut_free]} type="checkbox" label={gettext "Nut Free"}/>
      </div>
      <div class="action">
        <.button type="submit" class="submit" phx-disable-with={gettext("Saving...")}>
          {gettext("Save Product")}
        </.button>
      </div>
    </.form>

    <datalist id="category_suggestions">
      <option :for={suggestion <- @category_suggestions} value={suggestion}>
        {suggestion}
      </option>
    </datalist>

    <.back navigate={~p"/#{@locale}/admin/merchants/#{@merchant_id}/products"}>
        {gettext("Back to Products")}
    </.back>
    """
  end

  def handle_event("validate", %{"product" => product_params}, socket) do
    changeset = Products.change_product(socket.assigns.product, product_params)

    assign(socket, :form, to_form(changeset, action: :validate))
    |> noreply()
  end

  def handle_event("suggest", %{"product" => params}, socket) do
    suggestions =
      socket.assigns.merchant_id
      |> Products.filter_product_categories(params["category"])
    {:noreply, assign(socket, category_suggestions: suggestions)}
  end

  def handle_event("save", %{"product" => product_params}, socket) do
    save_product(socket, socket.assigns.live_action, product_params)
  end

  defp save_product(socket, :new, product_params) do
    merchant_id = socket.assigns.merchant_id |> String.to_integer()

    Products.create_product(merchant_id, product_params)
    |> handle_save_results(socket, gettext("Product created successfully!"))
  end

  defp save_product(socket, :edit, product_params) do
    Products.update_product(socket.assigns.product, product_params)
    |> handle_save_results(socket, gettext("Product updated successfully!"))
  end

  defp handle_save_results(result, socket, message) do
    case result do
      {:ok, _product} ->
        socket
        |> put_flash(:info, message)
        |> push_navigate(
          to: ~p"/#{socket.assigns.locale}/admin/merchants/#{socket.assigns.merchant_id}/products"
        )
        |> noreply()

      {:error, %Ecto.Changeset{} = changeset} ->
        assign(socket, :form, to_form(changeset))
        |> noreply()
    end
  end

end
