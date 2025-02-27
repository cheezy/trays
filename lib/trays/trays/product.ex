defmodule Trays.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc false

  schema "products" do
    field :name, :string
    field :description, :string
    field :category, :string
    field :image_path, :string
    field :price, Money.Ecto.Amount.Type

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :category, :image_path, :price])
    |> validate_required([:name, :description, :category, :image_path, :price])
    |> validate_length(:description, min: 10, max: 250)
    |> validate_length(:name, min: 4, max: 100)
    |> validate_length(:category, min: 4, max: 100)
  end
end
