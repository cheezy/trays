defmodule Trays.Repo.Migrations.AddModifierGroupIdToModifier do
  use Ecto.Migration

  def change do
    alter table(:modifier) do
      add :modifier_group_id, references(:modifier_group)
    end

    create index(:modifier, [:modifier_group_id])
  end
end
