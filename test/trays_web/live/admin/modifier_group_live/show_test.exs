defmodule TraysWeb.Admin.ModiferGrouplive.ShowTest do
  use TraysWeb.ConnCase

  alias Trays.AccountsFixtures
  alias Trays.MerchantFixtures
  alias Trays.ModifierGroupFixtures
  alias Trays.ModifierFixtures
  import Phoenix.LiveViewTest
  
  @moduledoc false

  setup %{conn: conn} do
    user = AccountsFixtures.user_fixture()
    merchant = MerchantFixtures.merchant_fixture_with_user(user)
    modifier_group = ModifierGroupFixtures.modifier_group_fixture(%{merchant_id: merchant.id})
    modifier1 = ModifierFixtures.modifier_fixture(%{modifier_group_id: modifier_group.id})
    modifier2 = ModifierFixtures.modifier_fixture(%{modifier_group_id: modifier_group.id})
    %{conn: log_in_user(conn, user), merchant: merchant, modifier_group: modifier_group, modifiers: [modifier1, modifier2]}
  end

  test "should show details for a Modifier Group",
       %{conn: conn, merchant: merchant, modifier_group: modifier_group} do
    {:ok, _view, html} = live(conn, "/en/admin/merchants/#{merchant.id}/modifier_groups/#{modifier_group.id}")

    assert html =~ modifier_group.name
    assert html =~ "Minimum modifiers: #{modifier_group.minimum}"
    assert html =~ "Maximum modifiers: #{modifier_group.maximum}"
  end

  test "should show the modifiers belonging to the modifier group",
       %{conn: conn, merchant: merchant, modifier_group: modifier_group, modifiers: modifiers} do
    {:ok, _view, html} = live(conn, "/en/admin/merchants/#{merchant.id}/modifier_groups/#{modifier_group.id}")

    Enum.each(modifiers, fn mod ->
      assert html =~ mod.name
    end)
  end

  test "should navigate to create a new modifier",
       %{conn: conn, merchant: merchant, modifier_group: modifier_group} do
    {:ok, view, _html} = live(conn, "/en/admin/merchants/#{merchant.id}/modifier_groups/#{modifier_group.id}")

    {:ok, _, html} =
      view
      |> element("#add-modifier-btn")
      |> render_click()
      |> follow_redirect(conn)

    assert html =~ "New Modifier"
  end

  test "should navigate to edit an existing modifier",
       %{conn: conn, merchant: merchant, modifier_group: modifier_group, modifiers: modifiers} do
    {:ok, view, _html} = live(conn, "/en/admin/merchants/#{merchant.id}/modifier_groups/#{modifier_group.id}")
    
    {:ok, _, html} =
      view
      |> element("#edit-modifier-#{List.first(modifiers).id}")
      |> render_click()
      |> follow_redirect(conn)

    assert html =~ "Edit Modifier"
  end
end
