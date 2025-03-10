defmodule Trays.Admin.Merchants do
  @moduledoc false

  alias Trays.Repo
  alias Trays.Merchant

  def list_merchants() do
    Merchant
    |> Repo.all()
  end

  def list_merchants_with_contacts() do
    list_merchants()
    |> Repo.preload(:contact)
  end

  def get_merchant!(id) do
    Repo.get!(Merchant, id)
  end

  def get_merchant_with_locations_and_contact!(id) do
    Repo.get!(Merchant, id) |> Repo.preload([[merchant_locations: :contact], :contact])
  end

  def change_merchant(%Merchant{} = merchant, attrs \\ %{}) do
    Merchant.changeset(merchant, attrs)
  end

  def create_merchant(attrs \\ %{}) do
    %Merchant{}
    |> Merchant.changeset(attrs)
    |> Repo.insert()
  end

  def update_merchant(%Merchant{} = merchant, attrs) do
    merchant
    |> Merchant.changeset(attrs)
    |> Repo.update()
  end

  def delete_merchant(%Merchant{} = merchant) do
    Repo.delete(merchant)
  end

  def default_merchant_logo_path() do
    Merchant.default_logo_path()
  end

  def get_merchant_categories() do
    [
      "Afghan",
      "All-Day Breakfast",
      "Bakery",
      "Bakery and Cafe",
      "BBQ",
      "Bagels",
      "Brunch",
      "Caribbean",
      "Chinese",
      "Coffee",
      "Donuts",
      "Ethiopian",
      "Filipino",
      "French",
      "Greek",
      "Indian",
      "Irish",
      "Italian",
      "Jamaican",
      "Japanese",
      "Korean",
      "Latin American",
      "Mediterranean",
      "Mexican",
      "Middle Eastern",
      "Pakistani",
      "Persian",
      "Pho",
      "Pizza",
      "Portuguese",
      "Pub Food",
      "Ramen",
      "Seafood",
      "Spanish",
      "Sushi",
      "Tacos",
      "Taiwanese",
      "Thai",
      "Turkish",
      "Vegan",
      "Vegetarian",
      "Vietnamese"
    ]
  end
end
