defmodule Trays.Repo.Migrations.AddPrepTimeToMerchantLocation do
  use Ecto.Migration

  def change do
    alter table(:merchant_locations) do
      add :prep_time, :integer
    end
  end
end
