defmodule Trays.Repo.Migrations.AddFieldsToMerchant do
  use Ecto.Migration

  def change do
    alter table(:merchants) do
      add :type, :string
      add :business_number, :string
    end
  end
end
