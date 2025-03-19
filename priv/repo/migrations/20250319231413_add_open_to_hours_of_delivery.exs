defmodule Trays.Repo.Migrations.AddOpenToHoursOfDelivery do
  use Ecto.Migration

  def change do
    alter table(:hours_of_delivery) do
      add :open, :boolean, default: false
    end
  end
end
