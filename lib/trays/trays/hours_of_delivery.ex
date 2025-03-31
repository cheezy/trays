defmodule Trays.HoursOfDelivery do

  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  schema "hours_of_delivery" do
    field :day, Ecto.Enum, values: [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]
    field :start_time, :time
    field :end_time, :time
    field :open, :boolean, default: false #add to the fixture and make it required

    belongs_to :merchant_location, Trays.MerchantLocation

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(hours_of_delivery, attrs) do
    hours_of_delivery
    |> cast(attrs, [
      :day,
      :start_time,
      :end_time,
      :open
    ])
    |> validate_required([
      :day,
      :start_time,
      :end_time
    ])
  end
end
