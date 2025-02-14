defmodule Trays.Repo.Migrations.CreateMerchants do
  use Ecto.Migration

  def change do
    create table(:merchants) do
      add :name, :string
      add :contact_name, :string
      add :contact_phone, :string
      add :contact_email, :string
      add :logo_path, :string
      add :description, :text
      add :food_category, :string
      add :store_image_path, :string

      timestamps(type: :utc_datetime)
    end
  end
end
