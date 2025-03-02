defmodule Trays.Repo.Migrations.AddContactIdToMerchant do
  use Ecto.Migration

  def change do
    alter table(:merchants) do
      add :contact_id, references(:users, on_delete: :nothing)
    end

    create index(:merchants, [:contact_id])
  end
end
