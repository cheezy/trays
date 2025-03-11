defmodule Trays.Repo.Migrations.AddSpecialInstructionsToMerchantLocation do
  use Ecto.Migration

  def change do
    alter table(:merchant_locations) do
      add :special_instruct, :string
    end
  end
end
