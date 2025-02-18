defmodule Trays.Repo.Migrations.CreateMerchantLocation do
  use Ecto.Migration

  def change do
    create table(:merchant_locations) do
      add :street1, :string
      add :street2, :string
      add :city, :string
      add :province, :string
      add :postal_code, :string
      add :country, :string
      add :contact_name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
