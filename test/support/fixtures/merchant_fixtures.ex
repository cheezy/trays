defmodule Trays.MerchantFixtures do
  @moduledoc false

  alias Trays.Admin.Merchants

  def unique_name, do: "Merchant #{System.unique_integer()}!"
  def valid_description, do: "Description of the merchant"
  def valid_food_category, do: "Good food served daily"
  def valid_contact_phone, do: "2342342342"
  def valid_logo_path, do: "/images/best_picture.png"

  def valid_merchant_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      name: unique_name(),
      description: valid_description(),
      food_category: valid_food_category(),
      contact_phone: valid_contact_phone(),
      logo_path: valid_logo_path()
    })
  end

  def merchant_fixture(attrs \\ %{}) do
    {:ok, merchant} =
      attrs
      |> valid_merchant_attributes()
      |> Merchants.create_merchant()

    merchant
  end

  def merchant_fixture_with_user(user, attrs \\ %{}) do
    merchant_fixture(Map.merge(attrs, %{contact_id: user.id}))
  end
end
