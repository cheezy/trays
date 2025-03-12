defmodule Trays.Repo.Migrations.AddModifierGroupIdToModifier do
  use Ecto.Migration

  def change do
    alter table(:modifier) do
      add :merchant_group_id, references(:modifier_group)
    end

    create index(:modifier, [:merchant_group_id])
  end
end
