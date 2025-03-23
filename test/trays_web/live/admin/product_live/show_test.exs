defmodule TraysWeb.Admin.ProductLive.ShowTest do
  use TraysWeb.ConnCase

  import Phoenix.LiveViewTest
  alias Trays.MerchantFixtures
  alias Trays.AccountsFixtures
  alias Trays.ProductFixtures
  alias Trays.ModifierGroupFixtures
  alias Trays.ModifierFixtures
  alias Trays.ProductModifierFixtures

  @moduledoc false

  setup %{conn: conn} do
    user = AccountsFixtures.user_fixture()
    merchant = MerchantFixtures.merchant_fixture_with_user(user)
    product = ProductFixtures.product_fixture(%{merchant_id: merchant.id})
    %{conn: log_in_user(conn, user), merchant: merchant, product: product}
  end

  test "should show details for a product",
      %{conn: conn, merchant: merchant, product: product} do
    {:ok, _view, html} = live(conn, "/en/admin/merchants/#{merchant.id}/products/#{product.id}")

    assert html =~ product.name
    assert html =~ "$#{product.price}"
  end

  test "should show the modifier groups for the product",
       %{conn: conn, merchant: merchant, product: product} do
    modifier_group = ModifierGroupFixtures.modifier_group_fixture(%{merchant_id: merchant.id})
    modifier = ModifierFixtures.modifier_fixture(%{modifier_group_id: modifier_group.id})
    product_modifier = ProductModifierFixtures.product_modifier_fixture(product, modifier)

    {:ok, _view, html} = live(conn, "/en/admin/merchants/#{merchant.id}/products/#{product.id}")

    assert html =~ modifier_group.name
    assert html =~ "Min: #{modifier_group.minimum} Max: #{modifier_group.maximum}"
    assert html =~ modifier.name
    assert html =~ "$#{product_modifier.price}"
  end
end
