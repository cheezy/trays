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
    field :delivery_option, Ecto.Enum, values: [:pickup, :delivery, :both], default: :both #style radio buttons
    field :prep_time, :integer
    field :cancellation_policy, :string


    # hours of deliveries - See Hours of Delivery item in Trello
    # holiday schedule

    # We need to collect bank information for each location

    # Need field for HST/GST - call it business number.

  # payment options - online, credit card, in person, pay on delivery

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
      :contact_id,
      :delivery_option,
      :prep_time,
      :cancellation_policy
    ])
    |> validate_required([
      :street1,
      :city,
      :province,
      :postal_code,
      :country,
      :merchant_id,
      :delivery_option,
      :prep_time,
      :cancellation_policy
    ])
    |> validate_length(:street1, min: 3, max: 100)
    |> validate_length(:city, min: 3, max: 100)
    |> validate_length(:province, min: 2, max: 30) #add custom validation to check provinces
    |> validate_format(:postal_code, ~r/^[A-Za-z]\d[A-Za-z]\s?\d[A-Za-z]\d$/, message: "must be a valid postal code")
    |> validate_inclusion(:country, ["Canada"], message: "Only \"Canada\" is allowed!") #ask ardita if she want's Canada to be defaulted and the user doesn't need to input it
    |> validate_number(:prep_time, greater_than: 23, less_than: 337) #for now prep time is between 24 hours and 2 weeks
    |> validate_length(:cancellation_policy, max: 200) #ask if locations should be required to write a cancellation policy
  end
end
