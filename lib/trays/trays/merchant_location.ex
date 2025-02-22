defmodule Trays.MerchantLocation do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc false

  schema "merchant_locations" do
    field :street1, :string
    field :street2, :string
    field :city, :string
    field :province, :string
    field :postal_code, :string
    field :country, :string
    field :contact_name, :string

    belongs_to :merchant, Trays.Merchant

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(merchant_location, attrs) do
    merchant_location
    |> cast(attrs, [:street1, :street2, :city, :province, :postal_code, :country, :contact_name])
    |> validate_required([:street1, :city, :province, :postal_code, :country, :contact_name])
  end
end
