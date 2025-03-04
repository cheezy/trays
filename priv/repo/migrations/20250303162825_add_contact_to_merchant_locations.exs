defmodule Trays.Repo.Migrations.AddContactToMerchantLocations do
  use Ecto.Migration

  def change do
    alter table(:merchant_locations) do
      add :contact_id, references(:users, on_delete: :nothing)
    end

    create index(:merchant_locations, [:contact_id])
  end
end
