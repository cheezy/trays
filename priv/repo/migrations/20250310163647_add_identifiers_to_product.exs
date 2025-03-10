defmodule Trays.Repo.Migrations.AddIdentifiersToProduct do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add :vegan, :boolean, default: false, null: false
      add :vegetarian, :boolean, default: false, null: false
      add :gluten_free, :boolean, default: false, null: false
      add :nut_free, :boolean, default: false, null: false
    end
  end
end
