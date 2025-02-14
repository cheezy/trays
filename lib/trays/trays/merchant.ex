defmodule Trays.Trays.Merchant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "merchants" do
    field :name, :string
    field :description, :string
    field :contact_name, :string
    field :contact_phone, :string
    field :contact_email, :string
    field :logo_path, :string
    field :food_category, :string
    field :store_image_path, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(merchant, attrs) do
    merchant
    |> cast(attrs, [
      :name,
      :contact_name,
      :contact_phone,
      :contact_email,
      :logo_path,
      :description,
      :food_category,
      :store_image_path
    ])
    |> validate_required([
      :name,
      :contact_name,
      :contact_phone,
      :contact_email,
      :logo_path,
      :description,
      :food_category,
      :store_image_path
    ])
    |> validate_length(:description, min: 10)
  end
end
