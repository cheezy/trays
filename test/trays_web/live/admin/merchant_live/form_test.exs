defmodule TraysWeb.Admin.MerchantLive.FormTest do
  use TraysWeb.ConnCase

  import Phoenix.LiveViewTest
  alias Trays.AccountsFixtures
  alias Trays.MerchantFixtures
  alias Trays.Merchant
  alias Trays.Repo

  @moduledoc false

  @cant_be_blank_error "can&#39;t be blank"

  describe "when action is new" do

    setup %{conn: conn} do
      user = AccountsFixtures.user_fixture()
      %{conn: log_in_user(conn, user), user: user}
    end

    test "should load the new merchant page", %{conn: conn} do
      conn = get(conn, "/en/admin/merchants/new")
      assert html_response(conn, 200) =~ "New Merchant"
    end

    test "should create a new merchant", %{conn: conn, user: user} do
      {:ok, view, _html} = live(conn, "/en/admin/merchants/new")

      view
      |> form("#merchant-form")
      |> render_submit(%{"merchant" => %{
          "name" => "Merchant Name",
          "category" => "Bakery & Cafe",
          "description" => "Food Description",
          "type" => "individual"
        }
      })

      [merchant | _] = Merchant |> Repo.all()
      refute merchant.id == nil
      assert merchant.contact_id == user.id
      assert merchant.type == :individual
      {path, flash} = assert_redirect(view)
      assert path == "/en/admin/merchants"
      assert flash["info"] == "Merchant created successfully!"
    end

    test "should validate fields", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/en/admin/merchants/new")

      assert view
        |> element("#merchant-form")
        |> render_change(MerchantFixtures.valid_merchant_attributes(%{description: ""}))
             =~ @cant_be_blank_error
    end
  end

  describe "when action is edit" do

    setup %{conn: conn} do
      user = AccountsFixtures.user_fixture()
      merchant = MerchantFixtures.merchant_fixture_with_user(user)

      %{conn: log_in_user(conn, user), user: user, merchant: merchant}
    end

    test "should load the edit merchant page", %{conn: conn, merchant: merchant} do
      conn = get(conn, "/en/admin/merchants/#{merchant.id}/edit")
      assert html_response(conn, 200) =~ "Edit Merchant"
    end

    test "should edit an existing merchant", %{conn: conn, merchant: merchant} do
      {:ok, view, _html} = live(conn, "/en/admin/merchants/#{merchant.id}/edit")

      view
      |> form("#merchant-form")
      |> render_submit(%{"merchant" => %{
        "name" => "Updated Name",
        "category" => "Pizza",
        "description" => "Updated Description"
        }
      })

      [merchant | _] = Merchant |> Repo.all()
      assert merchant.name == "Updated Name"
      assert merchant.category == "Pizza"
      assert merchant.description == "Updated Description"
    end

    test "should edit individual or business for a merchant", %{conn: conn, merchant: merchant} do
      {:ok, view, _html} = live(conn, "/en/admin/merchants/#{merchant.id}/edit")

      view
      |> form("#merchant-form")
      |> render_submit(%{"merchant" => %{
          "type" => "individual"
        }
      })

      [merchant | _] = Merchant |> Repo.all()
      assert merchant.type == :individual
    end
  end
end
