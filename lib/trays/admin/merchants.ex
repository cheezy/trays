defmodule Trays.Admin.Merchants do

    @moduledoc false

  alias Trays.Repo
  alias Trays.Merchant
  alias Trays.MerchantLocation

  def list_merchants() do
    Merchant
    |> Repo.all()
  end

  def get_merchant!(id) do
    Repo.get!(Merchant, id)
  end

  def get_merchant_with_locations!(id) do
    Repo.get!(Merchant, id) |> Repo.preload(:merchant_locations)
  end

  def change_merchant(%Merchant{} = merchant, attrs \\ %{}) do
    Merchant.changeset(merchant, attrs)
  end

  def create_merchant(attrs \\ %{}) do
    %Merchant{}
    |> Merchant.changeset(attrs)
    |> Repo.insert()
  end

    def update_merchant(%Merchant{} = merchant, attrs) do
      merchant
    |> Merchant.changeset(attrs)
    |> Repo.update()
  end

  def delete_merchant(%Merchant{} = merchant) do
    Repo.delete(merchant)
  end
end