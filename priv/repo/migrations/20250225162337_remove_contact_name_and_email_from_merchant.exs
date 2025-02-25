defmodule Trays.Repo.Migrations.RemoveContactNameAndEmailFromMerchant do
  use Ecto.Migration

  def change do
    alter table(:merchants) do
      remove :contact_name
      remove :contact_email
    end
  end
end
