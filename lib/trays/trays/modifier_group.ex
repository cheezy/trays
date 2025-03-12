defmodule Trays.ModifierGroup do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc false

  schema "modifier_group" do
    field :name, :string
    field :maximum, :integer
    field :minimum, :integer

    has_many :modifiers, Trays.Modifier

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(modifier_group, attrs) do
    modifier_group
    |> cast(attrs, [:name, :minimum, :maximum])
    |> validate_required([:name, :minimum, :maximum])
  end
end
