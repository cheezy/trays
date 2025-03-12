defmodule Trays.ModifierGroup do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc false

  schema "modifier_group" do
    field :name, :string
    field :maximum, :integer, default: 0
    field :minimum, :integer, default: 0

    has_many :modifiers, Trays.Modifier
    belongs_to :merchant, Trays.Merchant

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(modifier_group, attrs) do
    modifier_group
    |> cast(attrs, [:name, :minimum, :maximum, :merchant_id])
    |> validate_required([:name, :merchant_id])
  end
end
