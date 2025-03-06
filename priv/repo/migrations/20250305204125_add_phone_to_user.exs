defmodule Trays.Repo.Migrations.AddPhoneToUser do
  use Ecto.Migration

  def change do

    alter table(:users) do
      add :phone_number, :string
    end

  end
end
