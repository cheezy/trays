defmodule Trays.Admin.MerchantsTest do
  use Trays.DataCase

  alias Trays.Admin.Merchants
  alias Trays.Merchant
  alias Trays.AccountsFixtures

  describe "merchant" do
    setup do
      user = AccountsFixtures.user_fixture()
      {:ok, user: user}
    end

    test "should create a merchant with valid data", context do
      valid_attrs = %{
        name: "Merchant Name",
        description: "Description of the merchant",
        food_category: "Good food served daily",
        contact_phone: "2342342342",
        logo_path: "/images/best_picture.png",
        contact_id: context.user.id
      }

      assert {:ok, %Merchant{} = merchant} = Merchants.create_merchant(valid_attrs)
      assert merchant.name == "Merchant Name"
      assert merchant.description == "Description of the merchant"
      assert merchant.food_category == "Good food served daily"
      assert merchant.contact_phone == "2342342342"
      assert merchant.logo_path == "/images/best_picture.png"
      assert merchant.contact_id == context.user.id
    end

  end
end
