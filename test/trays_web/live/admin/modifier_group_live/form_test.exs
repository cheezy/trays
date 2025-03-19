defmodule TraysWeb.Admin.ModifierGroupLive.FormTest do
  use TraysWeb.ConnCase

  import Phoenix.LiveViewTest
  alias Trays.AccountsFixtures
  alias Trays.MerchantFixtures
  alias Trays.ModifierGroupFixtures
  alias Trays.ModifierGroup
  alias Trays.Repo

  @moduledoc false

  @cant_be_blank_error "can&#39;t be blank"

  describe "when action is new"  do
    setup %{conn: conn} do
      user = AccountsFixtures.user_fixture()
      merchant = MerchantFixtures.merchant_fixture_with_user(user)

      %{conn: log_in_user(conn, user), merchant: merchant}
    end

    test "should load the modifier groups page", %{conn: conn, merchant: merchant} do
      conn = get(conn, ~p"/en/admin/merchants/#{merchant.id}/modifier_groups/new")
      assert html_response(conn, 200) =~ "New Modifier Group"
    end

    test "should create a new modifier group", %{conn: conn, merchant: merchant} do
      {:ok, view, _html} = live(conn, "/en/admin/merchants/#{merchant.id}/modifier_groups/new")

      view
      |> form("#modifier-groups-form")
      |> render_submit(%{"modifier_group" => %{
          "name" => "Modifier Group Name",
          "minimum" => "1",
          "maximum" => "2",
          "merchant_id" => merchant.id
        }
      })

      [modifier_group | _] = ModifierGroup |> Repo.all()
      refute modifier_group.id == nil
      assert modifier_group.merchant_id == merchant.id
      assert modifier_group.name == "Modifier Group Name"
      {path, flash} = assert_redirect(view)
      assert path == "/en/admin/merchants/#{merchant.id}/modifier_groups"
      assert flash["info"] == "Modifier Group created successfully!"
    end

    test "should validate fields", %{conn: conn, merchant: merchant} do
      {:ok, view, _html} = live(conn, "/en/admin/merchants/#{merchant.id}/modifier_groups/new")

      assert view
        |> element("#modifier-groups-form")
        |> render_change(ModifierGroupFixtures.valid_modifier_group(%{name: ""}))
             =~ @cant_be_blank_error
    end
  end

  describe "when action is edit" do
    setup %{conn: conn} do
      user = AccountsFixtures.user_fixture()
      merchant = MerchantFixtures.merchant_fixture_with_user(user)
      modifier_group = ModifierGroupFixtures.modifier_group_fixture(merchant_id: merchant.id)

      %{conn: log_in_user(conn, user), merchant: merchant, modifier_group: modifier_group}
    end

    test "should load the edit page", %{conn: conn, merchant: merchant, modifier_group: modifier_group} do
      conn = get(conn, edit_url(merchant, modifier_group))
      assert html_response(conn, 200) =~ "Edit Modifier Group"
    end

    test "should edit an existing modifier group", %{conn: conn, merchant: merchant, modifier_group: modifier_group} do
      {:ok, view, _html} = live(conn, edit_url(merchant, modifier_group))

      view
      |> form("#modifier-groups-form")
      |> render_submit(%{"modifier_group" => %{
        "name" => "Updated Name",
        }
      })

      [modifier_group | _] = ModifierGroup |> Repo.all()
      assert modifier_group.name == "Updated Name"
    end

    defp edit_url(merchant, modifier_group) do
      "/en/admin/merchants/#{merchant.id}/modifier_groups/#{modifier_group.id}/edit"
    end
  end

end
