defmodule Trays.AdminProductsTest do
  use Trays.DataCase

  alias Trays.Admin.Products
  alias Trays.Product
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

  test "should retrieve a list of all products", %{merchant: merchant, product: product} do
    all_products = Products.list_products_for_merchant(merchant.id)
    assert [product] == all_products
  end

  test "should retrieve a list of products with their merchant", %{merchant: merchant} do
    [product_with_merchant | _] = Products.list_products_with_merchant(merchant.id)
    assert merchant.id == product_with_merchant.merchant.id
  end

  test "should retrieve a product by its' id", %{product: product} do
    retrieved = Products.get_product!(product.id)
    assert product.name == retrieved.name
    assert product.description == retrieved.description
  end

  test "should create a valid changeset that can be used by a form" do
    attrs = ProductFixtures.valid_product_attributes()
    changeset = Products.change_product(%Product{}, attrs)
    assert changeset.valid? == true
  end

  test "should create an empty changeset" do
    changeset = Products.change_product(%Product{})
    assert changeset.action == nil
  end

  test "should write a product to the database", %{merchant: merchant} do
    attrs = ProductFixtures.valid_product_attributes(%{merchant_id: merchant.id})
    {:ok, product} = Products.create_product(merchant.id, attrs)
    assert product.name == attrs.name
    assert product.description == attrs.description
  end

  test "should update a product", %{product: product} do
    attrs = %{name: "updated name", description: "updated description"}
    {:ok, product} = Products.update_product(product, attrs)
    assert product.name == attrs.name
    assert product.description == attrs.description
  end
end
