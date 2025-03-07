defmodule Trays.Repo.Migrations.AddDeliveryOptionToMerchantLocation do
  use Ecto.Migration

  def change do
    alter table(:merchant_locations) do
      add :delivery_option, :string
    end
  end
end
