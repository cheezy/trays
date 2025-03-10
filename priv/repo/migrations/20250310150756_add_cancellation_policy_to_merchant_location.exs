defmodule Trays.Repo.Migrations.AddCancellationPolicyToMerchantLocation do
  use Ecto.Migration

  def change do
    alter table(:merchant_locations) do
      add :cancellation_policy, :string
    end
  end
end
