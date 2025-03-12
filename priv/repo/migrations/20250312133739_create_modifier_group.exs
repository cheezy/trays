defmodule Trays.Repo.Migrations.CreateModifierGroup do
  use Ecto.Migration

  def change do
    create table(:modifier_group) do
      add :name, :string
      add :minimum, :integer
      add :maximum, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
