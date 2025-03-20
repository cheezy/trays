defmodule TraysWeb.Admin.ModifierLive.FormTest do
  use TraysWeb.ConnCase

  alias Trays.AccountsFixtures
  alias Trays.MerchantFixtures
  alias Trays.ModifierGroupFixtures
  alias Trays.ModifierFixtures
  alias Trays.Modifier
  alias Trays.Repo
  import Phoenix.LiveViewTest

  @moduledoc false

  @cant_be_blank_error "can&#39;t be blank"

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

    test "should validate fields",
         %{conn: conn, merchant: merchant, modifier_group: modifier_group} do
      {:ok, view, _html} =
        live(conn, "/en/admin/merchants/#{merchant.id}/modifier_groups/#{modifier_group.id}/modifier/new")

      assert view
        |> element("#modifier-form")
        |> render_change(ModifierFixtures.valid_modifier(%{name: ""}))
             =~ @cant_be_blank_error
    end

    test "should create a new modifier",
         %{conn: conn, merchant: merchant, modifier_group: modifier_group} do
      {:ok, view, _html} =
          live(conn, "/en/admin/merchants/#{merchant.id}/modifier_groups/#{modifier_group.id}/modifier/new")

      view
      |> form("#modifier-form")
      |> render_submit(%{"modifier" => %{
          "name" => "Modifier Name",
          "vegetarian" => "true",
          "vegan" => "false",
          "gluten_free" => "false",
          "nut_free" => "true",
        }
      })

      [modifier | _] = Modifier |> Repo.all()
      refute modifier.id == nil
      assert modifier.modifier_group_id == modifier_group.id
      assert modifier.name == "Modifier Name"
      {path, flash} = assert_redirect(view)
      assert path == "/en/admin/merchants/#{merchant.id}/modifier_groups/#{modifier_group.id}"
      assert flash["info"] == "Modifier created successfully!"
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

    test "should edit an existing modifier",
         %{conn: conn, merchant: merchant, modifier_group: modifier_group, modifier: modifier} do
      {:ok, view, _html} =
          live(conn, "/en/admin/merchants/#{merchant.id}/modifier_groups/#{modifier_group.id}/modifier/#{modifier.id}/edit")

      view
      |> form("#modifier-form")
      |> render_submit(%{"modifier" => %{
        "name" => "Updated Name",
        }
      })

      [modifier | _] = Modifier |> Repo.all()
      assert modifier.name == "Updated Name"
    end

  end
end
