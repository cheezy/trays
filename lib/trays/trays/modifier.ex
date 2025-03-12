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

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(modifier, attrs) do
    modifier
    |> cast(attrs, [:name, :gluten_free, :vegan, :vegetarian, :nut_free])
    |> validate_required([:name])
  end
end
