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
    |> validate_zero_or_greater(:price)
    |> assoc_constraint(:product)
    |> assoc_constraint(:modifier)
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
