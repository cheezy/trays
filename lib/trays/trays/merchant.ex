defmodule Trays.Merchant do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc false

  schema "merchants" do
    field :name, :string
    field :description, :string
    field :contact_name, :string, default: "First Last"
    field :contact_phone, :string, default: "1111111111"
    field :contact_email, :string, default: "first@example.com"
    field :logo_path, :string, default: "/images/logo_placeholder.jpg"
    field :food_category, :string

    has_many :merchant_locations, Trays.MerchantLocation
    belongs_to :contact, Trays.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(merchant, attrs) do
    merchant
    |> cast(attrs, [:name, :contact_name, :contact_phone, :contact_email, :logo_path,
      :description, :food_category])
    |> validate_required([:name, :contact_name, :contact_phone, :contact_email,
      :logo_path, :description, :food_category])
    |> validate_length(:description, min: 10)
  end
end
