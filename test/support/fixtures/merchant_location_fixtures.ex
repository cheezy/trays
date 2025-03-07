defmodule Trays.MerchantLocationFixtures do
  @moduledoc false

  alias Trays.Admin.Merchants

  def valid_street1(), do: "123 Yonge Street"
  def valid_street2(), do: "Unit 1500"
  def valid_city(), do: "Toronto"
  def valid_province(), do: "ON"
  def valid_postal_code(), do: "M3M 3M3"
  def valid_country(), do: "Canada"

  def valid_merchant_location_attrs(attrs \\ %{}) do
    Enum.into(attrs, %{
      street1: valid_street1(),
      street2: valid_street2(),
      city: valid_city(),
      province: valid_province(),
      postal_code: valid_postal_code(),
      country: valid_country()
    })
  end

  def merchant_location_fixture(merchant, attrs \\ %{}) do
    location_attrs = valid_merchant_location_attrs(attrs)
    {:ok, merchant_location} = Merchants.create_merchant_location(merchant.id, location_attrs)
    merchant_location
  end
end
