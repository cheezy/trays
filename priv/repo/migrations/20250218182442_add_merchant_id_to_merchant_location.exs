defmodule Trays.Repo.Migrations.AddMerchantIdToMerchantLocation do
  use Ecto.Migration

  def change do
    alter table(:merchant_locations) do
      add :merchant_id, references(:merchants)
    end

    create index(:merchant_locations, [:merchant_id])
  end
end
