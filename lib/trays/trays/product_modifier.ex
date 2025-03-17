defmodule Trays.ProductModifier do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc false

  schema "product_modifier" do
    field :price, Money.Ecto.Amount.Type

    belongs_to :product, Trays.Product
    belongs_to :modifier, Trays.Modifier

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product_modifier, attrs) do
    product_modifier
    |> cast(attrs, [:price, :product_id, :modifier_id])
    |> validate_required([:price, :product_id, :modifier_id])
  end
end
