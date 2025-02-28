defmodule Trays.Repo.Migrations.AddMerchantIdToProduct do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add :merchant_id, references(:merchants)
    end

    create index(:products, [:merchant_id])
  end
end
