defmodule Trays.Merchant do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc false

  schema "merchants" do
    field :name, :string
    field :description, :string
    field :contact_phone, :string, default: "1111111111"
    field :logo_path, :string, default: "/images/logo_placeholder.jpg"
    field :food_category, :string

    has_many :merchant_locations, Trays.MerchantLocation
    belongs_to :contact, Trays.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(merchant, attrs) do
    merchant
    |> cast(attrs, [:name, :contact_phone, :logo_path, :description, :food_category, :contact_id])
    |> validate_required([:name, :contact_phone, :logo_path, :description, :food_category, :contact_id])
    |> validate_length(:description, min: 10, max: 500)
    |> validate_length(:name, min: 4, max: 100)
    |> validate_length(:food_category, min: 2, max: 100)
  end
end
