defmodule Trays.AdminProductsTest do
  use Trays.DataCase

  alias Trays.Admin.Products
  alias Trays.AccountsFixtures
  alias Trays.MerchantFixtures
  alias Trays.ProductFixtures

  @moduledoc false

  setup do
    user = AccountsFixtures.user_fixture()
    merchant = MerchantFixtures.merchant_fixture_with_user(user)
    product = ProductFixtures.product_fixture_with_merchant(merchant)
    {:ok, merchant: merchant, product: product}
  end

  test "should retrieve a list of all products", context do
    all_products = Products.list_products_for_merchant(context.merchant.id)
    assert [context.product] == all_products
  end

  test "should retrieve a list of products with their merchant", context do
    [product_with_merchant | _] = Products.list_products_with_merchant(context.merchant.id)
    assert context.merchant.id == product_with_merchant.merchant.id
  end
end
