defmodule TraysWeb.Admin.ModifierLive.FormTest do
  use TraysWeb.ConnCase

  alias Trays.AccountsFixtures
  alias Trays.MerchantFixtures
  alias Trays.ModifierGroupFixtures
  alias Trays.ModifierFixtures

  @moduledoc false

  describe "when action is new" do

    setup %{conn: conn} do
      user = AccountsFixtures.user_fixture()
      merchant = MerchantFixtures.merchant_fixture_with_user(user)
      modifier_group = ModifierGroupFixtures.modifier_group_fixture(%{merchant_id: merchant.id})

      %{conn: log_in_user(conn, user), merchant: merchant, modifier_group: modifier_group}
    end

    test "should load the new modifier page",
         %{conn: conn, merchant: merchant, modifier_group: modifier_group} do
      conn = get(conn, ~p"/en/admin/merchants/#{merchant.id}/modifier_groups/#{modifier_group.id}/modifier/new")
      assert html_response(conn, 200) =~ "New Modifier"
    end
  end

  describe "when action is edit" do
    setup %{conn: conn} do
      user = AccountsFixtures.user_fixture()
      merchant = MerchantFixtures.merchant_fixture_with_user(user)
      modifier_group = ModifierGroupFixtures.modifier_group_fixture(%{merchant_id: merchant.id})
      modifier = ModifierFixtures.modifier_fixture(%{modifier_group_id: modifier_group.id})

      %{conn: log_in_user(conn, user), merchant: merchant, modifier_group: modifier_group, modifier: modifier}
    end

    test "should load the edit modifier page",
         %{conn: conn, merchant: merchant, modifier_group: modifier_group, modifier: modifier} do
      conn = get(conn, ~p"/en/admin/merchants/#{merchant.id}/modifier_groups/#{modifier_group.id}/modifier/#{modifier.id}/edit")
      assert html_response(conn, 200) =~ "Edit Modifier"
    end
  end
end
