defmodule Trays.Repo.Migrations.RemovePhoneFromMerchant do
  use Ecto.Migration

  def change do
    alter table(:merchants) do
      remove :contact_phone
    end
  end
end
