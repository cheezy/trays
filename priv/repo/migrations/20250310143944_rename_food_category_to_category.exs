defmodule Trays.Repo.Migrations.RenameFoodCategoryToCategory do
  use Ecto.Migration

  def change do
    rename table("merchants"), :food_category, to: :category
  end
end
