defmodule Trays.Admin.Merchants do

    @moduledoc false

  alias Trays.Repo
  alias Trays.Merchant
  alias Trays.MerchantLocation

  def list_merchants() do
    Merchant
    |> Repo.all()
  end

  def get_merchant!(id) do
    Repo.get!(Merchant, id)
  end

  def get_merchant_with_locations!(id) do
    Repo.get!(Merchant, id) |> Repo.preload(:merchant_locations)
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

  def get_merchant_location_with_merchant!(id) do
    Repo.get!(MerchantLocation, id) |> Repo.preload(:merchant)
  end

  def get_merchant_location!(id) do
    Repo.get!(MerchantLocation, id)
  end

  def change_merchant_location(%MerchantLocation{} = location, attrs \\ %{}) do
    MerchantLocation.changeset(location, attrs)
  end

  def create_merchant_location(merchant_id, attrs \\ %{}) do
    %MerchantLocation{merchant_id: merchant_id}
    |> MerchantLocation.changeset(attrs)
    |> Repo.insert()
  end

  def update_merchant_location(%MerchantLocation{} = location, attrs) do
    location
    |> MerchantLocation.changeset(attrs)
    |> Repo.update()
  end

  def delete_merchant_location(%MerchantLocation{} = merchant_location) do
    Repo.delete(merchant_location)
  end

  def get_provinces() do
    [
      {"Alberta", "AB"},
      {"British Columbia", "BC"},
      {"Manitoba", "MB"},
      {"New Brunswick", "NB"},
      {"Newfoundland and Labrador", "NL"},
      {"Nova Scotia", "NS"},
      {"Nunaut", "NU"},
      {"Ontario", "ON"},
      {"Prince Edward Island", "PE"},
      {"Quebec", "QC"},
      {"Saskatchewan", "SK"},
      {"Yukon", "YK"}
    ]
  end
end