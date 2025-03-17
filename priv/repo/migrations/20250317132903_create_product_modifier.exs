defmodule Trays.Repo.Migrations.CreateProductModifier do
  use Ecto.Migration

  def change do
    create table(:product_modifier) do
      add :price, :integer
      add :product_id, references(:products, on_delete: :delete_all), null: false
      add :modifier_id, references(:modifier, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:product_modifier, [:product_id])
    create index(:product_modifier, [:modifier_id])
  end
end
