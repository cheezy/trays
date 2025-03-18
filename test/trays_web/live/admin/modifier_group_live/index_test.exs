defmodule Traysweb.Admin.ModifierGroupLive.IndexTest do
  use TraysWeb.ConnCase

  import Phoenix.LiveViewTest
  alias Trays.ModifierGroupFixtures
  alias Trays.ModifierFixtures
  alias Trays.AccountsFixtures
  alias Trays.MerchantFixtures

  setup %{conn: conn} do
    user = AccountsFixtures.user_fixture()
    merchant = MerchantFixtures.merchant_fixture_with_user(user)
    modifier_group = ModifierGroupFixtures.modifier_group_fixture(%{merchant_id: merchant.id})
    modifier1 = ModifierFixtures.modifier_fixture(%{modifier_group_id: modifier_group.id})
    modifier2 = ModifierFixtures.modifier_fixture(%{modifier_group_id: modifier_group.id})
    %{conn: log_in_user(conn, user), merchant: merchant, modifier_group: modifier_group, modifiers: [modifier1, modifier2]}
  end

  test "should load the page and display modifier groups",
       %{conn: conn, merchant: merchant, modifier_group: modifier_group} do
    {:ok, _view, html} = live(conn, "/en/admin/merchants/#{merchant.id}/modifier_groups")
    assert html =~ "Modifier Groups"
    assert html =~ modifier_group.name
  end
end
