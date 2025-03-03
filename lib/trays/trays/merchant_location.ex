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

  # special instructions to get to location
  # hours of deliveries
  # lead time for delivery
  # cancellation policy
  # payment options - online, credit card, in person, pay on delivery
  # holiday schedule
  # delivery options - delivery / pickup

    belongs_to :merchant, Trays.Merchant
    belongs_to :contact, Trays.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(merchant_location, attrs) do
    merchant_location
    |> cast(attrs, [
      :street1,
      :street2,
      :city,
      :province,
      :postal_code,
      :country,
      :contact_name,
      :merchant_id
    ])
    |> validate_required([
      :street1,
      :city,
      :province,
      :postal_code,
      :country,
      :contact_name,
      :merchant_id
    ])
  end
end
