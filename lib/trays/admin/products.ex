defmodule Trays.Admin.Products do
  alias Trays.Repo
  alias Trays.Product
  import Ecto.Query

  @moduledoc false

  def list_products_for_merchant(merchant_id) do
    Product
    |> with_merchant(merchant_id)
    |> Repo.all()
  end

  def list_products_with_merchant(merchant_id) do
    list_products_for_merchant(merchant_id)
    |> Repo.preload(:merchant)
  end

  def with_merchant(query, merchant_id) do
    where(query, merchant_id: ^merchant_id)
  end

  def get_product!(id) do
    Repo.get!(Product, id)
  end

  def get_product_with_product_modifiers!(id) do
    get_product!(id)
    |> Repo.preload(:product_modifiers)
  end

  def change_product(%Product{} = product, attrs \\ %{}) do
    Product.changeset(product, attrs)
  end

  def create_product(merchant_id, attrs) do
    %Product{merchant_id: merchant_id}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  def get_product_categories_for(merchant_id) do
    query =
      from p in Product,
        where: p.merchant_id == ^merchant_id,
        order_by: :category,
        select: p.category
    Repo.all(query) |> Enum.uniq()
  end
  
  def filter_product_categories(merchant_id, prefix) do
    Enum.filter(get_product_categories_for(merchant_id),
        fn category -> String.contains?(String.upcase(category), String.upcase(prefix)) end)
  end
end
