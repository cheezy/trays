defmodule Trays.Repo.Migrations.AddMerchantIdToModifierGroup do
  use Ecto.Migration

  def change do
    alter table(:modifier_group) do
      add :merchant_id, references(:merchants)
    end

    create index(:modifier_group, [:merchant_id])
  end
end
