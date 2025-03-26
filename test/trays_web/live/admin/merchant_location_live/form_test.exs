defmodule TraysWeb.Admin.MerchantLocationLive.FormTest do
  use TraysWeb.ConnCase

  import Phoenix.LiveViewTest
  alias Trays.AccountsFixtures
  alias Trays.MerchantFixtures
  alias Trays.MerchantLocation
  alias Trays.MerchantLocationFixtures
  alias Trays.Repo

  @cant_be_blank_error "can&#39;t be blank"

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
      |> render_submit(%{
        "merchant_location" => %{
          "street1" => "Street One",
          "street2" => "Street Two",
          "city" => "Toronto",
          "province" => "ON",
          "postal_code" => "M1M 1M1",
          "country" => "Canada",
          "delivery_option" => "pickup",
          "prep_time" => 24,
          "cancellation_policy" => "new cancellation policy",
          "special_instruct" => "instructions to get to location"
        }
      })

      [location | _] = MerchantLocation |> Repo.all() |> Repo.preload(:contact)
      refute location.id == nil
      {path, flash} = assert_redirect(view)
      assert location.contact.id == user.id
      assert location.delivery_option == :pickup
      assert path == "/en/admin/merchants/#{merchant.id}"
      assert flash["info"] == "Merchant Location created successfully!"
    end

    test "should validate fields", %{conn: conn, merchant: merchant} do
      {:ok, view, _html} = live(conn, "/en/admin/merchants/#{merchant.id}/locations/new")

      assert view
             |> element("#merchant-location-form")
             |> render_change(MerchantLocationFixtures.valid_merchant_location_attrs(%{city: ""})) =~
               @cant_be_blank_error
    end
  end

  describe "when action is edit" do
    setup %{conn: conn} do
      user = AccountsFixtures.user_fixture()
      merchant = MerchantFixtures.merchant_fixture_with_user(user)

      location =
        MerchantLocationFixtures.merchant_location_fixture(merchant, %{contact_id: user.id})

      %{conn: log_in_user(conn, user), user: user, merchant: merchant, location: location}
    end

    test "should load the merchant location edit page", %{
      conn: conn,
      merchant: merchant,
      location: location
    } do
      conn = get(conn, ~p"/en/admin/merchants/#{merchant.id}/locations/#{location.id}/edit")
      assert html_response(conn, 200) =~ "Edit Merchant Location"
    end

    test "should edit a merchant location", %{
      conn: conn,
      merchant: merchant,
      location: location,
      user: user
    } do
      {:ok, view, _html} =
        live(conn, "/en/admin/merchants/#{merchant.id}/locations/#{location.id}/edit")

      view
      |> form("#merchant-location-form")
      |> render_submit(%{
        "merchant_location" => %{
          "street1" => "Street Three",
          "street2" => "Street Four",
          "city" => "London",
          "province" => "ON",
          "postal_code" => "M1M 1M2",
          "country" => "Canada",
          "delivery_option" => "both",
          "prep_time" => 48,
          "cancellation_policy" => "edit cancellation policy",
          "special_instruct" => "new instruction to get to location",
          "hours_of_delivery[monday][start_time]" => "11:00:00",
          "hours_of_delivery[monday][end_time]" => "19:00:00",
          "hours_of_delivery[tuesday][start_time]" => "11:00:00",
          "hours_of_delivery[tuesday][end_time]" => "19:00:00",
          "hours_of_delivery[wednesday][start_time]" => "11:00:00",
          "hours_of_delivery[wednesday][end_time]" => "19:00:00",
          "hours_of_delivery[thursday][start_time]" => "11:00:00",
          "hours_of_delivery[thursday][end_time]" => "19:00:00",
          "hours_of_delivery[friday][start_time]" => "11:00:00",
          "hours_of_delivery[friday][end_time]" => "19:00:00",
          "hours_of_delivery[saturday][start_time]" => "11:00:00",
          "hours_of_delivery[saturday][end_time]" => "19:00:00",
          "hours_of_delivery[sunday][start_time]" => "11:00:00",
          "hours_of_delivery[sunday][end_time]" => "19:00:00"
        }
      })

      location =
        Repo.get!(MerchantLocation, location.id)
        |> Repo.preload([:contact, :hours_of_delivery])

      {path, flash} = assert_redirect(view)
      assert location.contact.id == user.id
      assert location.delivery_option == :both
      assert path == "/en/admin/merchants/#{merchant.id}"
      assert flash["info"] == "Merchant Location updated successfully!"
    end
  end
end
