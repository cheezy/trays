defmodule Trays.Repo.Migrations.RemoveBusinessNumberFromMerchant do
  use Ecto.Migration

  def change do
    alter table(:merchants) do
      remove :business_number
    end

  end
end
