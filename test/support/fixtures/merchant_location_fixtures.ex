defmodule Trays.MerchantLocationFixtures do
  @moduledoc false

  alias Trays.Admin.MerchantLocations
  alias Trays.HoursOfDelivery
  alias Trays.Repo

  def valid_street1(), do: "123 Yonge Street"
  def valid_street2(), do: "Unit 1500"
  def valid_city(), do: "Toronto"
  def valid_province(), do: "ON"
  def valid_postal_code(), do: "M3M 3M3"
  def valid_country(), do: "Canada"
  def valid_delivery_option(), do: "pickup"
  def valid_prep_time(), do: 24
  def valid_cancellation_policy(), do: "Cancel for a full refund before 24 hours until delivery."
  def valid_special_instruct(), do: "Enter from Bay, then take the escalator down."

  def valid_merchant_location_attrs(attrs \\ %{}) do
    Enum.into(attrs, %{
      street1: valid_street1(),
      street2: valid_street2(),
      city: valid_city(),
      province: valid_province(),
      postal_code: valid_postal_code(),
      country: valid_country(),
      delivery_option: valid_delivery_option(),
      prep_time: valid_prep_time(),
      cancellation_policy: valid_cancellation_policy(),
      special_instruct: valid_special_instruct()
    })
  end

  def valid_hours_of_delivery_attrs(merchant_location_id) do
    [
      %{
        day: :monday,
        start_time: ~T[09:00:00],
        end_time: ~T[17:00:00],
        open: true,
        merchant_location_id: merchant_location_id
      },
      %{
        day: :tuesday,
        start_time: ~T[09:00:00],
        end_time: ~T[17:00:00],
        open: true,
        merchant_location_id: merchant_location_id
      },
      %{
        day: :wednesday,
        start_time: ~T[09:00:00],
        end_time: ~T[17:00:00],
        open: true,
        merchant_location_id: merchant_location_id
      },
      %{
        day: :thursday,
        start_time: ~T[09:00:00],
        end_time: ~T[17:00:00],
        open: true,
        merchant_location_id: merchant_location_id
      },
      %{
        day: :friday,
        start_time: ~T[09:00:00],
        end_time: ~T[17:00:00],
        open: true,
        merchant_location_id: merchant_location_id
      },
      %{
        day: :saturday,
        start_time: ~T[09:00:00],
        end_time: ~T[17:00:00],
        open: true,
        merchant_location_id: merchant_location_id
      },
      %{
        day: :sunday,
        start_time: ~T[09:00:00],
        end_time: ~T[17:00:00],
        open: true,
        merchant_location_id: merchant_location_id
      }
    ]
  end

  def merchant_location_fixture(merchant, attrs \\ %{}) do
    location_attrs = valid_merchant_location_attrs(attrs)

    {:ok, merchant_location} =
      MerchantLocations.create_merchant_location(merchant.id, location_attrs)

    hours_of_delivery_attrs = valid_hours_of_delivery_attrs(merchant_location.id)

    Enum.each(hours_of_delivery_attrs, fn attrs ->
      %HoursOfDelivery{}
      |> HoursOfDelivery.changeset(attrs)
      |> Repo.insert!()
    end)

    merchant_location
  end
end
