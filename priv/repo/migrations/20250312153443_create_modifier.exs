defmodule Trays.Repo.Migrations.CreateModifier do
  use Ecto.Migration

  def change do
    create table(:modifier) do
      add :name, :string
      add :gluten_free, :boolean, default: false, null: false
      add :vegan, :boolean, default: false, null: false
      add :vegetarian, :boolean, default: false, null: false
      add :nut_free, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
