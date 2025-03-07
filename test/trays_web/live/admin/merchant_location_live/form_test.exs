defmodule TraysWeb.Admin.MerchantLocationLive.FormTest do
  use TraysWeb.ConnCase

  import Phoenix.LiveViewTest
  alias Trays.AccountsFixtures
  alias Trays.MerchantFixtures
  alias Trays.MerchantLocation
  alias Trays.Repo

  describe "when action is new" do
    setup %{conn: conn} do
      user = AccountsFixtures.user_fixture()
      merchant = MerchantFixtures.merchant_fixture_with_user(user)

      %{conn: log_in_user(conn, user), user: user, merchant: merchant}
    end

    test "should load the merchant locations page", %{conn: conn, merchant: merchant} do
      conn = get(conn, ~p"/en/admin/merchants/#{merchant.id}/locations/new")
      assert html_response(conn, 200) =~ "New Merchant Location"
    end

    test "should create a new merchant location", %{conn: conn, merchant: merchant, user: user} do
      {:ok, view, _html} = live(conn, "/en/admin/merchants/#{merchant.id}/locations/new")

      view
      |> form("#merchant-location-form")
      |> render_submit(%{"merchant_location" => %{
          "street1" => "Street One",
          "street2" => "Street Two",
          "city" => "Toronto",
          "province" => "ON",
          "postal_code" => "M1M 1M1",
          "country" => "Canada"
        }
      })

      [location | _] = MerchantLocation |> Repo.all() |> Repo.preload(:contact)
      refute location.id == nil
      {path, flash} = assert_redirect(view)
      assert location.contact.id == user.id
      assert path == "/en/admin/merchants/#{merchant.id}"
      assert flash["info"] == "Merchant Location created successfully!"
    end
  end
end
