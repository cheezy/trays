defmodule Trays.Trays.Product do
  use Ecto.Schema
  import Ecto.Changeset

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
  end
end
