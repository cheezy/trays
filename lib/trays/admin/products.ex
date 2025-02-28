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

  def with_merchant(query, merchant_id) when merchant_id in ["", nil], do: query

  def with_merchant(query, merchant_id) do
    where(query, merchant_id: ^merchant_id)
  end
end
