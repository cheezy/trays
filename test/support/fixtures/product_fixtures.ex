defmodule Trays.ProductFixtures do
  @moduledoc false

  alias Trays.Repo
  alias Trays.Product

  def unique_name, do: "Product #{System.unique_integer()}!"
  def valid_description, do: "Description of the product"
  def valid_category, do: "Breakfast"
  def valid_image_path, do: "/images/product.png"
  def valid_price, do: Money.new(12, :CAD)

  def valid_product_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      name: unique_name(),
      description: valid_description(),
      category: valid_category(),
      image_path: valid_image_path(),
      price: valid_price(),
      merchant_id: 3
    })
  end


  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      %Product{}
      |> Product.changeset(valid_product_attributes(attrs))
      |> Repo.insert()

    product
  end

end
