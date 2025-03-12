defmodule Trays.Modifier do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc false

  schema "modifier" do
    field :name, :string
    field :gluten_free, :boolean, default: false
    field :vegan, :boolean, default: false
    field :vegetarian, :boolean, default: false
    field :nut_free, :boolean, default: false

    belongs_to :modifier_group, Trays.ModifierGroup

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(modifier, attrs) do
    modifier
    |> cast(attrs, [:name, :gluten_free, :vegan, :vegetarian, :nut_free, :modifier_group_id])
    |> validate_required([:name, :modifier_group_id])
  end
end
