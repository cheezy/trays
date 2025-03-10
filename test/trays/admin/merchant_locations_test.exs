defmodule Trays.Admin.MerchantLocationsTest do
  use Trays.DataCase

  alias Trays.Repo
  alias Trays.AccountsFixtures
  alias Trays.MerchantFixtures
  alias Trays.MerchantLocationFixtures
  alias Trays.MerchantLocation
  alias Trays.Admin.MerchantLocations

  describe "Merchant Locations" do
    setup do
      user = AccountsFixtures.user_fixture()
      merchant = MerchantFixtures.merchant_fixture_with_user(user)
      merchant_location = MerchantLocationFixtures.merchant_location_fixture(merchant, %{contact_id: user.id})
      {:ok, user: user, merchant: merchant, location: merchant_location}
    end

    test "should retrieve a location and its associated merchant", context do
      location = MerchantLocations.get_merchant_location_with_merchant!(context.location.id)

      assert location.street1 == context.location.street1
      assert location.merchant.id == context.merchant.id
    end

    test "should retrieve a merchant location by its' id", context do
      location = MerchantLocations.get_merchant_location!(context.location.id)

      assert location.street1 == context.location.street1
      assert location.city == context.location.city
    end

    test "should create a merchant location with a merchant id", context do
      attrs = MerchantLocationFixtures.valid_merchant_location_attrs(%{contact_id: context.user.id})
      {:ok, location} = MerchantLocations.create_merchant_location(context.merchant.id, attrs)

      assert location.street1 == attrs.street1
      refute location.id == nil
    end

    test "should update an existing merchant location", context do
      update_attrs = %{"street1" => "updated street", "city" => "updated city"}
      MerchantLocations.update_merchant_location(context.location, update_attrs)
      updated_location = MerchantLocations.get_merchant_location!(context.location.id)
      assert updated_location.street1 == "updated street"
      assert updated_location.city == "updated city"
    end

    test "should delete a merchant location", context do
      MerchantLocations.delete_merchant_location(context.location)
      assert Repo.get(MerchantLocation, context.location.id) == nil
    end
  end

  describe "Getting Provinces and Territories" do
    provinces = MerchantLocations.get_provinces()
    assert length(provinces) == 12
  end

end