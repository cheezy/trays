defmodule Trays.Repo.Migrations.RemoveContactNameFromMerchantLocation do
  use Ecto.Migration

  def change do
    alter table(:merchant_locations) do
      remove :contact_name
    end
  end
end
