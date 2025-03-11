defmodule TraysWeb.Admin.ProductLive.FormTest do
  use TraysWeb.ConnCase

  import Phoenix.LiveViewTest
  alias Trays.Repo
  alias Trays.AccountsFixtures
  alias Trays.MerchantFixtures
  alias Trays.ProductFixtures
  alias Trays.Product

  @moduledoc false

  @cant_be_blank_error "can&#39;t be blank"

  describe "when action is new" do
    setup %{conn: conn} do
      user = AccountsFixtures.user_fixture()
      merchant = MerchantFixtures.merchant_fixture_with_user(user)
      %{conn: log_in_user(conn, user), merchant: merchant}
    end

    test "should load the new merchant page", %{conn: conn, merchant: merchant} do
      conn = get(conn, "/en/admin/merchants/#{merchant.id}/products/new")
      assert html_response(conn, 200) =~ "New Product"
    end

    test "should create a new product", %{conn: conn, merchant: merchant} do
      {:ok, view, _html} = live(conn, "/en/admin/merchants/#{merchant.id}/products/new")

      view
      |> form("#product-form")
      |> render_submit(%{"product" => %{
          "name" => "Product Name",
          "description" => "Food Description",
          "price" => "10.00",
          "merchant_id" => merchant.id
        }
      })

      [product | _] = Product |> Repo.all()
      refute product.id == nil
      assert product.merchant_id == merchant.id
      assert product.name == "Product Name"
      {path, flash} = assert_redirect(view)
      assert path == "/en/admin/merchants/#{merchant.id}/products"
      assert flash["info"] == "Product created successfully!"
    end

    test "should validate fields", %{conn: conn, merchant: merchant} do
      {:ok, view, _html} = live(conn, "/en/admin/merchants/#{merchant.id}/products/new")

      assert view
        |> element("#product-form")
        |> render_change(MerchantFixtures.valid_merchant_attributes(%{description: ""}))
             =~ @cant_be_blank_error
    end
  end

  describe "when action is edit" do
    setup %{conn: conn} do
      user = AccountsFixtures.user_fixture()
      merchant = MerchantFixtures.merchant_fixture_with_user(user)
      product = ProductFixtures.product_fixture(%{merchant_id: merchant.id})
      %{conn: log_in_user(conn, user), merchant: merchant, product: product}
    end

    test "should load the edit page", %{conn: conn, merchant: merchant, product: product} do
      conn = get(conn, edit_url(merchant, product))
      assert html_response(conn, 200) =~ "Edit Products"
    end

    test "should edit an existing product", %{conn: conn, merchant: merchant, product: product} do
      {:ok, view, _html} = live(conn, edit_url(merchant, product))

      view
      |> form("#product-form")
      |> render_submit(%{"product" => %{
        "name" => "Updated Name",
        "description" => "Updated Description"
        }
      })

      [product | _] = Product |> Repo.all()
      assert product.name == "Updated Name"
      assert product.description == "Updated Description"
    end

    test "should filter categories", %{conn: conn, merchant: merchant, product: product} do
      {:ok, view, _html} = live(conn, edit_url(merchant, product))

      assert view
        |> element("#category")
        |> render_change(%{"category" => "B"})
             =~ "<option value=\"Breakfast\">"
    end

    defp edit_url(merchant, product) do
      "/en/admin/merchants/#{merchant.id}/products/#{product.id}/edit"
    end
  end
end
