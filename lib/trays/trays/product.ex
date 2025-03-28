defmodule Trays.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc false

  schema "products" do
    field :name, :string
    field :description, :string
    field :category, :string # should move out to another schema
    field :image_path, :string, default: "/images/default-product-image.png"
    field :price, Money.Ecto.Amount.Type

    field :gluten_free, :boolean, default: false
    field :vegan, :boolean, default: false
    field :vegetarian, :boolean, default: false
    field :nut_free, :boolean, default: false

    belongs_to :merchant, Trays.Merchant
    has_many :product_modifiers, Trays.ProductModifier

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs,
         [
           :name, :description, :image_path, :price, :merchant_id,
           :gluten_free, :vegan, :vegetarian, :nut_free, :category
         ]
       )
    |> validate_required([:name, :description, :price, :merchant_id])
    |> validate_length(:description, min: 10, max: 250)
    |> validate_length(:name, min: 4, max: 100)
    |> validate_zero_or_greater(:price)
  end

  def validate_zero_or_greater(changeset, field) when is_atom(field) do
    validate_change(changeset, field, fn _field, value ->
      case Money.negative?(value) do
        true ->
          [{field, "must be zero or greater"}]

        false ->
          []
      end
    end)
  end
end
