defmodule Trays.Repo.Migrations.CreateHoursOfDelivery do
  use Ecto.Migration

  def change do
    create table(:hours_of_delivery) do
      add :day, :string
      add :start_time, :time
      add :end_time, :time
      add :merchant_location_id, references(:merchant_locations, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:hours_of_delivery, [:merchant_location_id])
  end
end
