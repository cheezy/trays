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
      :merchant_id,
      :contact_id
    ])
    |> validate_required([
      :street1,
      :city,
      :province,
      :postal_code,
      :country,
      :merchant_id
    ])
    |> validate_length(:street1, min: 1, max: 100)
    |> validate_length(:street2, min: 1, max: 100)
    |> validate_length(:city, min: 3, max: 100)
    |> validate_length(:province, min: 2, max: 30) #add custom validation to check provinces
    |> validate_length(:postal_code, min: 6, max: 7)
    |> validate_inclusion(:country, ["Canada"], message: "Only \"Canada\" is allowed!") #ask ardita if she want's Canada to be defaulted and the user doesn't need to input it
  end
end
