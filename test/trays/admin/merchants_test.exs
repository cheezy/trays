defmodule Trays.Admin.MerchantsTest do
  use Trays.DataCase

  alias Trays.Repo
  alias Trays.Admin.Merchants
  alias Trays.Merchant
  alias Trays.MerchantLocation
  alias Trays.AccountsFixtures
  alias Trays.MerchantFixtures
  alias Trays.MerchantLocationFixtures

  describe "Merchant" do
    setup do
      user = AccountsFixtures.user_fixture()
      merchant = MerchantFixtures.merchant_fixture_with_user(user)
      {:ok, user: user, merchant: merchant}
    end

    test "should create a merchant with valid data", context do
      valid_attrs = MerchantFixtures.valid_merchant_attributes(%{contact_id: context.user.id})
      assert {:ok, %Merchant{} = merchant} = Merchants.create_merchant(valid_attrs)
      assert merchant.name == valid_attrs.name
    end

    test "should not create a merchant when valid data is not provided" do
      assert {:error, changeset} = Merchants.create_merchant()
      assert changeset.valid? == false
    end

    test "should retrieve a merchant by its' id", context do
      retrieved = Merchants.get_merchant!(context.merchant.id)
      assert context.merchant.name == retrieved.name
    end

    test "should retrieve a list of all merchants", context do
      all_merchants = Merchants.list_merchants()
      assert [context.merchant] == all_merchants
    end

    test "should retrieve a list of merchants with their contacts", context do
      [merchant_with_contact | _] = Merchants.list_merchants_with_contacts()
      assert context.merchant.contact_id == merchant_with_contact.contact.id
    end

    test "should create a changeset that can be used by a new form", context do
      valid_attrs = MerchantFixtures.valid_merchant_attributes(%{contact_id: context.user.id})
      changeset = Merchants.change_merchant(%Merchant{}, valid_attrs)
      assert changeset.valid? == true
    end

    test "should create an empty changeset" do
      changeset = Merchants.change_merchant(%Merchant{})
      assert changeset.action == nil
    end

    test "should update a merchant", context do
      Merchants.update_merchant(context.merchant, %{name: "Updated Name"})
      updated_merchant = Merchants.get_merchant!(context.merchant.id)
      assert updated_merchant.name == "Updated Name"
    end

    test "should delete a merchant", context do
      Merchants.delete_merchant(context.merchant)
      assert Repo.get(Merchant, context.merchant.id) == nil
    end
  end

  describe "Merchant Locations" do
    setup do
      user = AccountsFixtures.user_fixture()
      merchant = MerchantFixtures.merchant_fixture_with_user(user)
      merchant_location = MerchantLocationFixtures.merchant_location_fixture(merchant, %{contact_id: user.id})
      {:ok, user: user, merchant: merchant, location: merchant_location}
    end

    test "should retrieve a location and its associated merchant", context do
      location = Merchants.get_merchant_location_with_merchant!(context.location.id)

      assert location.street1 == context.location.street1
      assert location.merchant.id == context.merchant.id
    end

    test "should retrieve a merchant location by its' id", context do
      location = Merchants.get_merchant_location!(context.location.id)

      assert location.street1 == context.location.street1
      assert location.city == context.location.city
    end

    test "should create a merchant location with a merchant id", context do
      attrs = MerchantLocationFixtures.valid_merchant_location_attrs(%{contact_id: context.user.id})
      {:ok, location} = Merchants.create_merchant_location(context.merchant.id, attrs)

      assert location.street1 == attrs.street1
      refute location.id == nil
    end

    test "should update an existing merchant location", context do
      update_attrs = %{"street1" => "updated street", "city" => "updated city"}
      Merchants.update_merchant_location(context.location, update_attrs)
      updated_location = Merchants.get_merchant_location!(context.location.id)
      assert updated_location.street1 == "updated street"
      assert updated_location.city == "updated city"
    end

    test "should delete a merchant location", context do
      Merchants.delete_merchant_location(context.location)
      assert Repo.get(MerchantLocation, context.location.id) == nil
    end
  end

  describe "Getting Provinces and Territories" do
    provinces = Merchants.get_provinces()
    assert length(provinces) == 12
  end
end
