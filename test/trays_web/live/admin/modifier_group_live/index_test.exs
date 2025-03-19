defmodule Traysweb.Admin.ModifierGroupLive.IndexTest do
  use TraysWeb.ConnCase

  import Phoenix.LiveViewTest
  alias Trays.ModifierGroupFixtures
  alias Trays.AccountsFixtures
  alias Trays.MerchantFixtures
  alias Trays.ModifierGroup
  alias Trays.Repo

  setup %{conn: conn} do
    user = AccountsFixtures.user_fixture()
    merchant = MerchantFixtures.merchant_fixture_with_user(user)
    modifier_group = ModifierGroupFixtures.modifier_group_fixture(%{merchant_id: merchant.id})
    %{conn: log_in_user(conn, user), merchant: merchant, modifier_group: modifier_group}
  end

  test "should load the page and display modifier groups",
       %{conn: conn, merchant: merchant, modifier_group: modifier_group} do
    {:ok, _view, html} = live(conn, "/en/admin/merchants/#{merchant.id}/modifier_groups")
    assert html =~ "Modifier Groups"
    assert html =~ modifier_group.name
  end

  test "should navigate to create a new modifier group",
       %{conn: conn, merchant: merchant} do
    {:ok, view, _html} = live(conn, "/en/admin/merchants/#{merchant.id}/modifier_groups")

    {:ok, _, html} =
      view
      |> element("#new_modifier_group_btn")
      |> render_click()
      |> follow_redirect(conn)

    assert html =~ "New Modifier Group"
  end

  test "should navigate to edit an existing modifier group",
       %{conn: conn, merchant: merchant} do
    {:ok, view, _html} = live(conn, "/en/admin/merchants/#{merchant.id}/modifier_groups")

    {:ok, _, html} =
      view
      |> element(".edit-modifier-group")
      |> render_click()
      |> follow_redirect(conn)

    assert html =~ "Edit Modifier Group"
  end

  test "should delete an existing modifier group",
       %{conn: conn, merchant: merchant, modifier_group: modifier_group} do
    {:ok, view, _html} = live(conn, "/en/admin/merchants/#{merchant.id}/modifier_groups")

    view
    |> element(".delete-modifier-group")
    |> render_click()

    assert Repo.get(ModifierGroup, modifier_group.id) == nil
  end
end
