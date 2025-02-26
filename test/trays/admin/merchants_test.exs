defmodule Trays.Admin.MerchantsTest do
  use Trays.DataCase

  alias Trays.Admin.Merchants
  alias Trays.Merchant
  alias Trays.AccountsFixtures
  alias Trays.MerchantFixtures

  describe "merchant" do
    setup do
      user = AccountsFixtures.user_fixture()
      merchant = MerchantFixtures.merchant_fixture(%{contact_id: user.id})
      {:ok, user: user, merchant: merchant}
    end

    test "should create a merchant with valid data", context do
      valid_attrs = MerchantFixtures.valid_merchant_attributes(%{contact_id: context.user.id})
      assert {:ok, %Merchant{} = merchant} = Merchants.create_merchant(valid_attrs)
      assert merchant.name == valid_attrs.name
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


  end
end
